# Azure Hub-Spoke Azure Firewall Routing Lab

## Overview

This project demonstrates a hub-spoke network architecture in Azure using Terraform, where outbound traffic from a spoke virtual network is routed through Azure Firewall in the hub.

The goal of this lab was to design, deploy, validate, and troubleshoot a centralized egress architecture using Azure-native security controls.

The lab focuses on:
- Centralized network security
- Segmentation between workloads
- Controlled ingress and egress traffic
- Azure Firewall deployment
- Infrastructure as Code (IaC)
- Cloud security engineering concepts

---

## Architecture

This lab uses a hub-and-spoke topology where:

- The hub virtual network contains shared security services
- Azure Firewall provides centralized traffic inspection
- Spoke virtual networks host isolated workloads
- User Defined Routes (UDRs) direct traffic through the firewall
- Network Security Groups (NSGs) enforce segmentation


## Architecture Diagram

![Azure Hub-Spoke Azure Firewall Routing Lab](./diagram.png)

---

## Key Components

### Hub VNet
- Address space: `10.0.0.0/16`
- Azure Firewall subnet: `10.0.1.0/26`
- Jump host subnet: `10.0.2.0/24`
- Azure Firewall private IP: `10.0.1.4`

---

### Spoke VNet
- Address space: `10.1.0.0/16`
- Workload subnet: `10.1.1.0/24`
- Spoke VM private IP: `10.1.1.4`

---

## Routing Design

- A User Defined Route (UDR) is applied to the spoke subnet:
  - `0.0.0.0/0 → 10.0.1.4`
- All outbound traffic from the spoke VM is forced through Azure Firewall
- Direct internet egress from the spoke is disabled by design

---

## Technologies Used

- Microsoft Azure
- Terraform
- Azure Firewall
- Virtual Networks (VNets)
- User Defined Routes (UDRs)
- Network Security Groups (NSGs)


---

## Azure Firewall Configuration

- Azure Firewall deployed in the hub network
- Firewall Policy attached for centralized rule management
- Network rules configured to allow outbound traffic for HTTP, HTTPS, and DNS
- Azure Firewall performs NAT and becomes the public egress identity for the spoke

---

## Access Model

- Jump host deployed in hub with public IP
- Spoke VM is private-only with no public IP
- SSH access path:

```text
Laptop → Jump Host → Spoke VM

---


## Security Concepts Demonstrated

- Centralized egress filtering
- Network segmentation
- Controlled routing paths
- Secure inbound publishing
- Infrastructure as Code deployment methodology

---

## Future Improvements

- Bastion integration
- IDS/IPS inspection
- Terraform modules
- CI/CD deployment pipeline
- Logging and monitoring integration
