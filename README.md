# Classroom Network Control

A Bash-based project developed during an internship at **IES Los Albares (Cieza, Spain)** to support controlled Internet access in computer classrooms during exams.

## Overview

The project provides a command-line workflow for enabling and disabling an **exam mode** on classroom network gateways. It uses SSH to run firewall commands on Linux-based Smoothwall systems, with the aim of limiting access to approved online resources during assessments and restoring normal connectivity afterwards.

> **Public portfolio version:** The files in this repository are intended to demonstrate the approach without publishing real institutional network details. They are not a ready-to-deploy configuration.

## Technologies

- **Bash** — scripting and command-line automation
- **Linux / Smoothwall** — network gateway environment
- **SSH** — remote administration
- **iptables / ip6tables** — IPv4 and IPv6 firewall rule management

## Main capabilities

- Apply a restricted network-access mode for classroom exams.
- Use an allowlist of permitted domains as part of the exam workflow.
- Restore normal network access after an exam.
- Manage the workflow through a Bash script rather than repeating manual commands.

## Repository contents

| File | Description |
| --- | --- |
| [`BloqueoFinal.sh`](BloqueoFinal.sh) | Bash script illustrating the network-control workflow. |
| [`Manual_BloqueoFinal_Publico.pdf`](Manual_BloqueoFinal_Publico.pdf) | Public project documentation. |
| [`dominios_ejemplo.txt`](dominios_ejemplo.txt) | Example domain allowlist. |

## How it works

At a high level, the script connects to the relevant Linux network gateway over SSH, applies firewall rules for the restricted exam environment, and provides a way to return to the normal network configuration when the exam is over.

The exact commands, prerequisites and supported options should be checked in the script and accompanying manual. **Do not run the script on a real network without reviewing its rules, testing a rollback procedure, and obtaining authorization.**

## Security and privacy

This repository is presented for educational and portfolio purposes. Real gateway addresses, credentials, school-specific topology and other sensitive configuration details should not be published. Any example values must be replaced and the firewall behavior independently reviewed before use in another environment.

## Context

Developed as part of a practical internship project involving Linux systems administration, Bash automation and network access control.

## Disclaimer

This is a demonstration of work completed in an educational environment, not a production-ready security product. Firewall changes can interrupt connectivity or lock out administrators if applied incorrectly.
