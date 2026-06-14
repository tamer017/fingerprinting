# WLAN Indoor Positioning via RSSI Fingerprinting

> **Two-phase Wi-Fi RSSI fingerprinting system for deterministic indoor localization across the GUC C3 building using nearest-neighbor RMS distance matching.**

[![MATLAB](https://img.shields.io/badge/Language-MATLAB-orange.svg)](https://www.mathworks.com/)
[![Domain](https://img.shields.io/badge/Domain-Indoor_Positioning-blue.svg)]()

---

## Overview

This project implements a complete **Wi-Fi fingerprinting-based indoor positioning system** for the German University in Cairo (GUC) C3 building. The system determines a user's location inside a building using only the Wi-Fi signal strengths (RSSI) from existing access points — no GPS, no additional hardware required.

---

## System Architecture

### Phase 1: Offline — Radio Map Construction

```
Surveyed Grid Points (known coordinates)
          │
  Measure RSSI from 5 APs at each point
  (multiple measurements for averaging)
          │
  Build Radio Map:
  Location (x,y) → [RSSI_AP1, RSSI_AP2, RSSI_AP3, RSSI_AP4, RSSI_AP5]
          │
  Store in fingerprint database
```

### Phase 2: Online — Real-Time Localization

```
Live RSSI Vector from 5 APs
          │
  Compute RMS distance to every reference point:
  d(p) = sqrt( mean( (RSSI_live - RSSI_ref[p])^2 ) )
          │
  Select point with minimum RMS distance
          │
  Return (x, y) coordinates
```

---

## Technical Details

### RSSI Distance Metric

The **Root Mean Square (RMS)** distance between a live reading and a reference fingerprint:

```
d = sqrt( (1/N) * sum_{i=1}^{N} (RSSI_live_i - RSSI_ref_i)^2 )
```

Where N = 5 (number of access points). This is a deterministic approach — no probabilistic models or ML required.

### Building Layout

| Parameter | Value |
|---|---|
| Building | GUC C3 Building |
| Access Points | 5 Wi-Fi APs |
| Grid resolution | ~1.5m spacing |
| RSSI range | -30 dBm (strong) to -90 dBm (weak) |

### Why RSSI Fingerprinting?

| Method | Accuracy | Infrastructure Needed |
|---|---|---|
| GPS | ~3m (outdoors only) | Satellite line-of-sight |
| Trilateration | ~5-10m | Path-loss model calibration |
| **Fingerprinting** | **~1-3m** | Only existing Wi-Fi APs |
| UWB | ~0.1m | Dedicated UWB anchors |

---

## MATLAB Implementation

```matlab
% Load radio map
load('radio_map.mat');  % [N_points x 5] RSSI matrix + coordinates

% Live measurement
rssi_live = [-65, -72, -58, -81, -69];  % dBm from 5 APs

% RMS distance to all reference points
diffs = radio_map.rssi - rssi_live;     % broadcasting
rms_dist = sqrt(mean(diffs.^2, 2));     % per-point RMS

% Nearest neighbor
[~, idx] = min(rms_dist);
estimated_pos = radio_map.coords(idx, :);
fprintf('Estimated position: (%.1f, %.1f) m\n', estimated_pos(1), estimated_pos(2));
```

---

## Installation

```bash
git clone https://github.com/tamer017/fingerprinting.git
cd fingerprinting
# Open in MATLAB R2020b+
# Run: main.m
```

---

## Skills & Concepts

`RSSI Fingerprinting` `Indoor Positioning` `WLAN` `Wi-Fi Localization` `MATLAB` `Signal Processing` `Nearest Neighbor Search` `RMS Distance` `Radio Map` `Location-Based Services`

---

## Author

**Ahmed Tamer Assy** — [GitHub](https://github.com/tamer017) | Machine Learning Researcher @ Volkswagen AG
