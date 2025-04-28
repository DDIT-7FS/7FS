let currentTarget = null;

const selectedMembers = [];



document.addEventListener('DOMContentLoaded', function () {
  console.log("🚀 editFormScript.js loaded");

  initAddressFields();
  formatDateFields();
  setupAmountInputFormat();
  setupFormSubmitWithValidation();
  setupOrgChartModalButtonHandler();
});

function initAddressFields() {
  const fullAddr = document.getElementById('prjctAdres')?.value || '';
  if (fullAddr.includes(',')) {
    const [addr1, addr2] = fullAddr.split(/,\s*/);
    document.getElementById('restaurantAdd1').value = addr1;
    document.getElementById('addressDetail').value = addr2;
  } else {
    document.getElementById('restaurantAdd1').value = fullAddr;
  }
}

function formatDateFields() {
  const beginDateInput = document.querySelector('[name="prjctBeginDate"]');
  const endDateInput = document.querySelector('[name="prjctEndDate"]');

  if (beginDateInput) beginDateInput.value = convertToInputDate(beginDateInput.value);
  if (endDateInput) endDateInput.value = convertToInputDate(endDateInput.value);
}

function convertToInputDate(val) {
  if (val && val.length === 8) {
    return `${val.slice(0, 4)}-${val.slice(4, 6)}-${val.slice(6, 8)}`;
  }
  return val;
}

function setupAmountInputFormat() {
  const amountInput = document.getElementById('prjctRcvordAmount');
  if (!amountInput) return;

  amountInput.addEventListener('input', function () {
    let value = this.value.replace(/[^0-9]/g, '');
    if (value) value = parseInt(value, 10).toLocaleString('ko-KR');
    this.value = value;
  });
}

function setupFormSubmitWithValidation() {
  const form = document.getElementById('projectForm');
  form.addEventListener('submit', function (e) {
    e.preventDefault();

    const requiredFields = ['prjctNo', 'ctgryNo', 'prjctNm', 'prjctCn', 'prjctSttus', 'prjctGrad', 'prjctBeginDate', 'prjctEndDate'];
    const missing = [];

    requiredFields.forEach(name => {
      const input = form.querySelector(`[name="${name}"]`) || form.querySelector(`input[type="hidden"][name="${name}"]`);
      if (!input || input.value.trim() === '') missing.push(name);
    });

    if (missing.length > 0) {
      console.warn("❗ 누락된 필드:", missing);
      swal("입력 오류", "모든 필수 항목을 입력해주세요.", "warning");
      return;
    }

    // 날짜 포맷 변경
    const begin = form.querySelector('[name="prjctBeginDate"]');
    const end = form.querySelector('[name="prjctEndDate"]');
    if (begin) {
      form.appendChild(createHiddenField('prjctBeginDate', begin.value.replace(/-/g, '')));
      begin.name = 'prjctBeginDateDisplay';
    }
    if (end) {
      form.appendChild(createHiddenField('prjctEndDate', end.value.replace(/-/g, '')));
      end.name = 'prjctEndDateDisplay';
    }

    // 수주금액 숫자만
    const amtInput = document.getElementById('prjctRcvordAmount');
    if (amtInput) amtInput.value = amtInput.value.replace(/[^0-9]/g, '');

    // 주소 병합
    const addr1 = document.getElementById('restaurantAdd1')?.value || '';
    const addr2 = document.getElementById('addressDetail')?.value || '';
    document.getElementById('prjctAdres').value = addr1 + (addr2 ? ', ' + addr2 : '');

    form.submit();
  });
}

function createHiddenField(name, value) {
  const input = document.createElement('input');
  input.type = 'hidden';
  input.name = name;
  input.value = value;
  return input;
}

function removeMember(button) {
  const row = button.closest('tr');
  if (row) row.remove();
  updateProjectEmpIndexes();
}

function setupOrgChartModalButtonHandler() {
  document.querySelectorAll(".open-org-chart").forEach(button => {
    button.addEventListener('click', function() {
      document.querySelectorAll('.open-org-chart').forEach(btn => btn.classList.remove('active'));
      this.classList.add('active');

      currentTarget = this.dataset.target; // 누를 때 기억
      console.log("선택한 역할:", currentTarget);

      const modalEl = document.getElementById("orgChartModal");
      const bsModal = bootstrap.Modal.getOrCreateInstance(modalEl);

      modalEl.removeAttribute("aria-hidden");
      bsModal.show();

      // 모달 열 때 loadOrgTree() 호출
      loadOrgTree(); 
    });
  });
}




// 주소 검색 함수 추가
function openAddressSearch() {
  new daum.Postcode({
    oncomplete: function(data) {
      document.getElementById('restaurantAdd1').value = data.address;
      document.getElementById('addressDetail').focus();
    }
  }).open();
}




// 선택된 인원 추가 함수
function addSelectedMembers(members) {
  const tableBody = document.querySelector("#selectedMembersTable tbody");
  if (!tableBody) return;

  // empty-row 삭제
  const emptyRow = tableBody.querySelector('.empty-row');
  if (emptyRow) emptyRow.remove();

  members.forEach(emp => {
    // 중복 체크 (같은 직원+같은 역할은 추가 금지)
    const exists = Array.from(tableBody.children).some(row =>
      row.dataset.empId === emp.emplNo && row.dataset.role === emp.role
    );
    if (exists) return; // 이미 추가된 경우 무시

    // 새 행 추가
    const row = document.createElement("tr");
    row.dataset.empId = emp.emplNo;
    row.dataset.role = emp.role;
	
	if (emp.role === 'responsibleManager') {
	  row.classList.add('bg-light-danger');
	} else if (emp.role === 'participants') {
	  row.classList.add('bg-light-primary');
	} else {
	  row.classList.add('bg-light-secondary');
	}

    let roleName = '';
    let badgeClass = '';
    let iconClass = '';

    if (emp.role === 'responsibleManager') {
      roleName = '책임자';
      badgeClass = 'bg-danger';
      iconClass = 'fas fa-user-tie';
    } else if (emp.role === 'participants') {
      roleName = '참여자';
      badgeClass = 'bg-primary';
      iconClass = 'fas fa-user-check';
    } else {
      roleName = '참조자';
      badgeClass = 'bg-secondary';
      iconClass = 'fas fa-user-clock';
    }

	if (emp.role === 'responsibleManager') {
	  row.classList.add('bg-light-danger');  // 책임자: 연한 빨강
	} else if (emp.role === 'participants') {
	  row.classList.add('bg-light-primary'); // 참여자: 연한 파랑
	} else {
	  row.classList.add('bg-light-secondary'); // 참조자: 연한 회색
	}
	
    // 전화번호 포맷
    const formattedPhone = formatPhone(emp.telno);

    row.innerHTML = `
      <td class="text-center">
        <span class="badge ${badgeClass} p-2">
          <i class="${iconClass} me-1"></i> ${roleName}
        </span>
      </td>
      <td class="text-center"><strong>${emp.emplNm || '-'}</strong></td>
      <td class="text-start ps-2">${emp.deptNm || '-'}</td>
      <td class="text-center">${emp.posNm || '-'}</td>
      <td class="text-center">
        <i class="fas fa-phone-alt me-1 text-muted"></i>${formattedPhone}
      </td>
      <td class="text-start ps-2">
        <i class="fas fa-envelope me-1 text-muted"></i>${emp.email || '-'}</td>
      <td class="text-center">
        <button type="button" class="btn btn-sm btn-outline-danger remove-member">
          <i class="fas fa-times"></i>
        </button>
      </td>
    `;

    // 삭제 버튼 이벤트
    row.querySelector(".remove-member").addEventListener("click", function () {
      row.remove();
      updateProjectEmpIndexes();
    });

    tableBody.appendChild(row);
  });

  updateProjectEmpIndexes();
}

// ✅ 조직도 로딩 함수
function loadOrgTree() {
  const treeContainer = document.getElementById('jstree');
  if (!treeContainer) {
    console.warn("jstree 요소가 없습니다.");
    return;
  }

  console.log("🚀 조직도 데이터 로딩 시작");

  fetch("/organization/detail")
    .then(resp => {
      if (!resp.ok) throw new Error(`조직도 데이터 로딩 실패: ${resp.status}`);
      return resp.json();
    })
    .then(res => {
      const deptList = res.deptList; // 부서
      const empList = res.empList;   // 사원

      console.log("✅ 부서 리스트:", deptList);
      console.log("✅ 사원 리스트:", empList);

      const json = [];

      deptList.forEach(dept => {
        json.push({
          id: dept.cmmnCode,
          parent: dept.upperCmmnCode || "#",
          text: dept.cmmnCodeNm,
          icon: "/assets/images/organization/department.svg",
          deptYn: true,
          original: {
            id: dept.cmmnCode,
            parent: dept.upperCmmnCode || "#",
            text: dept.cmmnCodeNm,
            deptYn: true
          }
        });
      });

      empList.forEach(emp => {
        json.push({
          id: emp.emplNo,
          parent: emp.deptCode || "#",
          text: emp.emplNm,
          icon: "/assets/images/organization/employeeImg.svg",
          deptYn: false,
          original: {
            id: emp.emplNo,
            parent: emp.deptCode || "#",
            text: emp.emplNm,
            deptYn: false,
            deptNm: emp.deptNm || '-',
            posNm: emp.posNm || '-',
            telno: emp.telno || '-',
            email: emp.email || '-'
          }
        });
      });

      $('#jstree').jstree('destroy');
      $('#jstree').jstree({
        core: {
          data: json,
          check_callback: true,
          themes: { responsive: false }
        },
        plugins: ["search"]
      });

      $('#jstree').on('select_node.jstree', function (e, data) {
        const node = data.node;
        if (!node || node.original?.deptYn) return;
        if (typeof clickEmp === 'function') {
          clickEmp(node.original);
        }
      });

    })
    .catch(error => {
      console.error("❌ 조직도 로딩 실패:", error);
    });
}




// 사원 클릭 시
function clickEmp(node) {
  if (!node || node.deptYn === true) return;

  console.log("💬 선택된 사원:", node);

  if (!currentTarget) {
    swal("선택 오류", "먼저 책임자/참여자/참조자 버튼을 눌러주세요.", "warning");
    return;
  }

  const emp = node.original; // 🔥 핵심: node.original에서 데이터 가져오기

  const newEmp = {
    emplNo: emp.id,        // 사번
    emplNm: emp.text,      // 이름
    deptNm: emp.deptNm || '-', // 부서명
    posNm: emp.posNm || '-',   // 직급
    telno: emp.telno || '-',   // 전화번호
    email: emp.email || '-',   // 이메일
    role: currentTarget
  };

  addSelectedMembers([newEmp]);
}




// ✅ 전화번호 포맷 함수
function formatPhone(phone) {
  if (!phone) return '-';
  const onlyNums = phone.replace(/[^0-9]/g, '');
  if (onlyNums.length === 11) {
    return onlyNums.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
  } else if (onlyNums.length === 10) {
    if (onlyNums.startsWith('02')) {
      return onlyNums.replace(/(\d{2})(\d{4})(\d{4})/, '$1-$2-$3');
    } else {
      return onlyNums.replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3');
    }
  }
  return phone;
}

// ✅ 참여자 삭제 버튼 클릭 시
function removeParticipant(button) {
  const row = button.closest('tr');
  row.remove();

  const tbody = document.querySelector("#selectedMembersTable tbody");
  if (tbody.children.length === 0) {
    const emptyRow = document.createElement('tr');
    emptyRow.className = 'empty-row';
    emptyRow.innerHTML = `
      <td colspan="7" class="text-center text-muted py-4">
        <i class="fas fa-info-circle me-1"></i> 선택된 인원이 없습니다. 조직도에서 프로젝트 참여자를 선택해주세요.
      </td>
    `;
    tbody.appendChild(emptyRow);
  }

  updateProjectEmpIndexes();
}

// ✅ 인덱스 재조정
function updateProjectEmpIndexes() {
  const participants = document.querySelectorAll('#selectedMembersTable tbody tr:not(.empty-row)');
  participants.forEach((row, index) => {
    const hiddenInputs = row.querySelectorAll('input[type="hidden"]');
    hiddenInputs.forEach(input => {
      if (input.name.includes('projectEmpVOList')) {
        input.name = input.name.replace(/projectEmpVOList\[\d+\]/, `projectEmpVOList[${index}]`);
      }
    });
  });
}
