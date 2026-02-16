# TransactionViewer

A SwiftUI iOS app that loads transactions from a bundled JSON file, displays them in a list, and shows detailed information for a selected transaction.

## Features

- Transaction list screen with loading, error, and loaded states.
- Transaction detail screen with formatted account and amount information.
- Local JSON-based data source (`transaction-list.json`) with async repository access.
- Clean layering with mappers and UI models to keep formatting/UI logic out of domain models.
- Unit tests for decoding, repository behavior, formatters, and list view model states.

## Tech Stack

- **Language:** Swift
- **UI:** SwiftUI
- **Architecture style:** Feature-based MVVM with repository abstraction
- **Data source:** Bundled JSON (no remote API required)
- **Testing:** XCTest

## Project Structure

```text
TransactionViewer/
├── App/
│   └── TransactionViewerApp.swift
├── Core/
│   ├── Models/
│   ├── Services/
│   ├── Repositories/
│   ├── Mappers/
│   └── Utilities/
├── Features/
│   ├── TransactionList/
│   ├── TransactionDetails/
│   └── UIRepresentation/
├── Resources/
│   └── transaction-list.json
└── Assets.xcassets/

TransactionViewerTests/
├── Core/
└── Features/
```

## Architecture Overview

- `TransactionListViewModel` requests data from `TransactionRepositoryProtocol`.
- `TransactionRepository` depends on `NetworkProtocol` to fetch and decode bundled JSON.
- Mapper types (`TransactionRowMapper`, `TransactionDetailMapper`) transform domain models into UI-friendly models.
- Views render only UI models / view model output.
- A lightweight `DI` container in `TransactionViewerApp` wires dependencies.

## Requirements

- Xcode 15+
- iOS 17+ target (or as configured in the Xcode project)

## Getting Started

1. Open the project in Xcode:
   - `TransactionViewer.xcodeproj`
2. Select the `TransactionViewer` scheme.
3. Build and run on an iOS Simulator.

## Running Tests

From Xcode:

- **Product → Test** (⌘U)

Or from terminal (on macOS with Xcode installed):

```bash
xcodebuild test \
  -project TransactionViewer.xcodeproj \
  -scheme TransactionViewer \
  -destination 'platform=iOS Simulator,name=iPhone 15'
```

## Sample Data

The app reads transactions from:

- `TransactionViewer/Resources/transaction-list.json`

This makes the app deterministic and easy to test without network dependencies.

## Notes

- `NetworkManager` is intentionally built around a protocol and endpoint abstraction so it can be swapped to a real API-backed implementation later.
- Currency/date formatting and card masking live in shared utilities for consistency across screens.
