# WLAN Location Fingerprinting — Indoor Positioning System

> An indoor positioning system using **Wi-Fi RSSI fingerprinting** to localize a receiver on the 2nd floor of the C3 building at GUC, using signal strengths from 5 Access Points.

[![Language](https://img.shields.io/badge/Language-MATLAB-blue?style=flat-square)](https://www.mathworks.com/products/matlab.html)
[![Method](https://img.shields.io/badge/Method-RSSI%20Fingerprinting-orange?style=flat-square)]()
[![Location](https://img.shields.io/badge/Location-GUC%20C3%20Building-green?style=flat-square)]()

---

## Overview

This project implements a **location fingerprinting technique** for accurate indoor positioning using Wi-Fi signal strength (RSSI) measurements. Traditional GPS is ineffective indoors due to signal attenuation, making RSSI-based fingerprinting a critical technique for indoor navigation, asset tracking, and emergency response.

The system localizes a receiver anywhere on the **2nd floor of the C3 building at the German University in Cairo (GUC)** by comparing live RSSI measurements from **5 WLAN Access Points** against a pre-recorded radio map of reference points.

---

## Methodology

### Phase 1: Offline Training (Radio Map Construction)

```
[Define Reference Grid on Floor Plan]
              |
              v
   [Measure RSSI from 5 APs at each reference point]
   AP1_power, AP2_power, AP3_power, AP4_power, AP5_power
              |
              v
   [Store as Radio Map: (x, y) → [P1, P2, P3, P4, P5]]
```

### Phase 2: Online Localization

```
[Receive live RSSI from 5 APs at unknown location]
              |
              v
   [Compute RMS distance to each reference point]
   RMS = sqrt( Σ(P_ref_i - P_live_i)^2 / N )
              |
              v
   [Select reference point with minimum RMS distance]
              |
              v
   [Output: (x, y) coordinates of estimated location]
```

---

## Technical Details

### RMS-Based Nearest Neighbor Matching
The core localization algorithm computes the **Root Mean Square (RMS) error** between the live received power vector and each fingerprint in the radio map. The reference point with the lowest RMS distance is selected as the estimated location.

**Formula:**
```
RMS(i) = sqrt( (1/5) * sum_j (P_ref_ij - P_live_j)^2 )
```
Where `P_ref_ij` is the power from AP `j` at reference point `i`, and `P_live_j` is the live power from AP `j`.

### Access Points
| AP | Coverage Zone |
|---|---|
| AP1 | North corridor |
| AP2 | East wing |
| AP3 | South corridor |
| AP4 | West wing |
| AP5 | Central area |

---

## System Specifications

| Property | Value |
|---|---|
| Building | GUC C3, Floor 2 |
| Access Points | 5 WLAN APs |
| Algorithm | RMS nearest-neighbor fingerprinting |
| Output | (x, y) coordinates on floor grid |
| Platform | MATLAB |

---

## Getting Started

### Prerequisites
- MATLAB R2016b or later
- Communications Toolbox (optional, for signal visualization)

### Running
1. Open MATLAB and navigate to the project directory
2. Load the radio map data (reference power measurements)
3. Run the main localization script:
   ```matlab
   run('fingerprinting_main.m')
   ```
4. Enter the live RSSI values when prompted
5. The estimated (x, y) coordinates are displayed

---

## Skills Demonstrated

- **Signal Processing:** RSSI measurement, path loss modeling, wireless channel characterization
- **Indoor Positioning:** Radio map construction, fingerprinting, nearest-neighbor matching
- **MATLAB:** Matrix operations, distance computation, data visualization
- **Applied Mathematics:** RMS error metric, vector space comparison
- **Wireless Networks:** WLAN (802.11) signal propagation, multi-AP localization

---

## References

- Bahl, P. & Padmanabhan, V.N. (2000). *RADAR: An in-building RF-based user location and tracking system*. IEEE INFOCOM.
- Youssef, M. & Agrawala, A. (2005). *The Horus WLAN location determination system*. ACM MobiSys.
