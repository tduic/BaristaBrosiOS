# Barista Bros (iOS)

A SwiftUI iOS app that drives an automated cocktail-mixing machine over Bluetooth. Pick a drink, tap order, and the app sends the recipe to the machine, which dispenses it — then reports back when it's done.

## Features

- **Order drinks** — browse a menu of cocktails (Tequila Sunrise, Screwdriver, Moscow Mule, Long Island Iced Tea, Old Fashioned, and more), each with its alcohol/mixer recipe, calorie count, and rating. Selecting one sends the order to the machine and shows live status until it reports `Dispensed!`.
- **Check liquids** — monitor the remaining level of each ingredient container (vodka, tequila, cola, orange juice) and trigger a refill when one runs low.
- **Accounts** — sign-up / login screens backed by Core Data.

## How it connects

The app talks to the machine over **Bluetooth Low Energy** using an HM-10 BLE module (`CBUUID 0xFFE0` service / `0xFFE1` characteristic). `Model/BLEConnection.swift` manages the full BLE lifecycle — scanning, connecting, discovering characteristics, and reading/writing values — using Apple's CoreBluetooth framework. Order and liquid-level commands are written to the characteristic; the machine writes status and sensor readings back.

## Tech

- **SwiftUI** for the UI (`Views/`)
- **CoreBluetooth** for the hardware link
- **Core Data** for user accounts (`Model.xcdatamodeld`)

## Project layout

```
BaristaBrosiOS/
├── BaristaBrosiOSApp.swift   # app entry point
├── Model/
│   ├── BLEConnection.swift   # Bluetooth LE communication with the machine
│   ├── Drink.swift           # cocktail recipes
│   ├── Liquid.swift          # ingredient containers
│   └── Profile.swift
└── Views/                    # Home, Order, CheckLiquid, Login, Signup, ...
```

## Running

Open `BaristaBrosiOS.xcodeproj` in Xcode and run on a physical iOS device (BLE is not available in the simulator). The companion drink machine, exposing an HM-10 BLE module, must be powered on and in range.
