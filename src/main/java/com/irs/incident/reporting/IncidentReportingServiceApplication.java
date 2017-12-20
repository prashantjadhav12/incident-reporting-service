package com.irs.incident.reporting;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

@SpringBootApplication
@EnableJpaAuditing
public class IncidentReportingServiceApplication {

	public static void main(String[] args) {
		SpringApplication.run(IncidentReportingServiceApplication.class, args);
	}
}
