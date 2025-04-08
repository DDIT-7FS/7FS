package kr.or.ddit.sevenfs.controller.mail;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/mail")
public class MailController {

	@GetMapping("")
	public String mailHome() {
		return "mail/mailHome";
	}
}
