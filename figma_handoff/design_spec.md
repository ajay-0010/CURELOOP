# CureLoop — Figma UI Handoff Specification
## PNG-Only Handoff

**Project:** CureLoop  
**Platform:** Flutter / Android  
**Purpose:** Reproduce the supplied Figma mobile UI inside the existing CureLoop Flutter application.

---

## 1. Important Handoff Constraint

This handoff contains **PNG screen exports only**.

No SVG/icon export package is being provided.

Therefore:

- Treat the PNG files as **visual references**, not as UI backgrounds.
- Do **not** expect SVG files to exist.
- Do **not** block implementation because SVG assets are unavailable.
- Do not convert an entire screen PNG into a background image.
- Recreate the UI using normal Flutter widgets.
- Recreate simple icons using Flutter's existing Material/Cupertino icon sets when visually appropriate.
- For custom/simple vector-like shapes, use Flutter widgets/custom painting only when necessary.
- If an exact visual asset cannot reasonably be recreated from the PNG, identify it as a remaining asset gap instead of inventing a completely different design.

The PNG exports are the source of truth for the visual appearance.

---

## 2. Available Screen References

The `figma_handoff/screens/` directory contains the exported Figma references:

- `onboarding-carousel-1.png`
- `onboarding-carousel-2.png`
- `onboarding-carousel-3.png`
- `phone-entry.png`
- `otp-verification.png`
- `profile-setup.png`
- `home-dashboard.png`
- `home-empty-state.png`
- `add-prescription-choice.png`
- `vault-list.png`
- `vault-detail.png`
- `vault-empty.png`
- `reminder-notification.png`
- `appointments-list.png`
- `add-appointment.png`
- `appointment-detail.png`
- `allergy-profile.png`
- `emergency-card.png`
- `lock-screen-widget.png`
- `family-profiles.png`
- `add-family-member.png`
- `settings-profile.png`
- `canvas.png`

`canvas.png` should be treated as an overall design/reference canvas, not necessarily as a navigable application screen.

---

## 3. Visual Source of Truth

Use the PNG exports to determine:

- overall screen composition
- spacing
- alignment
- component placement
- colors
- typography hierarchy
- button appearance
- card appearance
- borders
- corner radii
- shadows
- icons
- illustrations
- navigation
- empty states
- input fields
- headers/app bars
- bottom navigation
- visual hierarchy

When exact numeric values cannot be determined from the PNG, choose the closest reasonable Flutter value and keep it centralized in design tokens.

Do not claim an exact Figma value unless it is actually available from the design or can be reliably measured.

---

## 4. Design Token Strategy

Create a centralized CureLoop design system rather than scattering values throughout widgets.

Suggested structure:

```text
lib/
  core/
    theme/
      cureloop_theme.dart
      cureloop_colors.dart
      cureloop_spacing.dart
      cureloop_radius.dart
      cureloop_typography.dart
```

The exact location may follow the existing project architecture.

### Colors

Extract the dominant colors from the PNG references.

Create semantic names such as:

- primary
- primaryContainer
- secondary
- background
- surface
- surfaceVariant
- textPrimary
- textSecondary
- textMuted
- border
- success
- warning
- error
- info

Do not hardcode colors repeatedly inside individual screens.

### Spacing

Create reusable spacing values for common gaps:

```text
xs
sm
md
lg
xl
xxl
```

Use these consistently across screens.

### Radius

Create reusable radius tokens for:

- small controls
- cards
- inputs
- buttons
- large containers
- bottom sheets

### Typography

Create semantic text styles for:

- display/title
- screen title
- section title
- body
- body secondary
- caption
- button label
- input text
- helper/error text

Match the PNG typography hierarchy as closely as possible.

If the exact Figma font is not available in the project, use the closest available system/Flutter font and document the substitution.

---

## 5. Screen Implementation Requirements

### Onboarding

References:

- `onboarding-carousel-1.png`
- `onboarding-carousel-2.png`
- `onboarding-carousel-3.png`

Reproduce:

- illustration placement
- title/subtitle hierarchy
- page indicators
- navigation controls
- spacing
- CTA styling

### Authentication

References:

- `phone-entry.png`
- `otp-verification.png`
- `profile-setup.png`

Preserve the existing authentication architecture and API integration.

Only change presentation.

If a development-only authentication bypass already exists, preserve it.

Do not create fake JWT tokens or remove backend authentication.

### Home

References:

- `home-dashboard.png`
- `home-empty-state.png`

Preserve existing API-driven data.

Implement both populated and empty states.

### Prescription Vault

References:

- `vault-list.png`
- `vault-detail.png`
- `vault-empty.png`
- `add-prescription-choice.png`

Preserve:

- prescription APIs
- draft state
- confirmation state
- search/filter behavior
- document access
- delete/resume draft functionality

### Prescription Safety / OCR

Use the relevant existing OCR/review screens and the closest visual references available.

Critical product rule:

**No prescription schedule may automatically become active.**

The existing flow must remain:

```text
DRAFT
  ↓
PENDING_CONFIRMATION
  ↓
CONFIRMED
```

Patient confirmation is mandatory before reminder activation.

Do not weaken or bypass this rule while changing the UI.

### Medicines / Reminders

Reference:

- `reminder-notification.png`

Preserve:

- dose events
- Taken
- Skip
- reminder scheduling
- timezone handling
- notification provider architecture

### Appointments

References:

- `appointments-list.png`
- `add-appointment.png`
- `appointment-detail.png`

Preserve existing appointment API and reminder logic.

### Profile / Safety

References:

- `settings-profile.png`
- `allergy-profile.png`
- `emergency-card.png`
- `family-profiles.png`
- `add-family-member.png`
- `lock-screen-widget.png`

Preserve existing profile/allergy/family data models and APIs.

---

## 6. Icons and Missing SVG Assets

Because SVG exports are unavailable:

### Preferred order

1. Existing project asset, if already present.
2. Flutter Material icon that visually matches.
3. Flutter Cupertino icon if it matches better.
4. A simple Flutter-drawn/custom icon when necessary.
5. Leave a clearly documented asset gap only when the graphic is genuinely custom and cannot be reasonably reproduced.

Do not use random icon packs merely because they are available.

Keep icon:

- size
- stroke/weight
- alignment
- padding
- color

consistent with the PNG reference.

---

## 7. Do Not Use Screen PNGs as UI Backgrounds

This is explicitly prohibited.

For example, do NOT implement:

```dart
Image.asset('home-dashboard.png')
```

as the entire Home screen.

Instead recreate:

- cards
- text
- buttons
- icons
- lists
- navigation
- illustrations
- spacing

as actual Flutter widgets.

The exported PNG is only the visual comparison target.

---

## 8. Existing Backend and Architecture Must Remain Intact

Do not remove or rewrite existing:

- FastAPI APIs
- repositories
- Riverpod providers
- Dio client
- authentication services
- secure storage
- prescription models
- OCR abstraction
- SafetyEngine
- reminder services
- FCM provider
- appointment services
- medicine/dose logic
- error handling

UI work must connect to the existing architecture.

No fake production data should be introduced.

---

## 9. Responsive Behavior

The references are mobile designs.

Optimize first for the current Android emulator/device.

Also ensure:

- no horizontal overflow
- no clipped text
- no RenderFlex overflow
- proper SafeArea usage
- scrollable long content
- keyboard-safe forms
- sensible behavior on different Android screen sizes

Avoid excessive absolute positioning.

Prefer:

- Column
- Row
- Stack only when appropriate
- Expanded
- Flexible
- ListView
- CustomScrollView
- SingleChildScrollView
- SafeArea
- LayoutBuilder

---

## 10. Visual Validation

For each implemented screen:

1. Launch the Flutter app.
2. Navigate to the corresponding screen.
3. Compare it against the matching PNG.
4. Check:
   - dimensions
   - spacing
   - typography
   - colors
   - alignment
   - component sizes
   - corner radius
   - shadows
   - icons
   - navigation
   - scrolling
5. Iterate until the visual result is close to the reference.

The goal is not merely to make the application compile.

The goal is:

**Figma PNG reference → faithful Flutter implementation → fully functional CureLoop screen**

---

## 11. Validation Commands

After UI implementation:

```bash
flutter analyze
flutter test
flutter build apk --debug
flutter run -d emulator-5554
```

All existing backend tests must continue passing.

---

## 12. What Counts as a Successful Handoff

A successful implementation means:

- all applicable exported screens are represented in Flutter
- PNGs were used as visual references
- no screen PNG is used as the actual UI background
- UI uses reusable design tokens
- missing SVGs do not block development
- icons are recreated appropriately
- existing APIs and business logic remain functional
- prescription safety confirmation remains enforced
- no fake authentication tokens are introduced
- no production functionality is removed
- Flutter analyzer passes
- tests pass
- debug APK builds
- the app runs on the Android emulator

---

## 13. Known Limitation

This is a **PNG-only design handoff**.

Exact Figma layer-level values, original vector assets, component variants, and editable design metadata are not included in this package.

When the PNG does not provide enough information to determine an exact value:

1. make the closest reasonable implementation;
2. centralize the value in the design system;
3. document the approximation;
4. continue implementation rather than blocking the project.

Do not invent major visual elements that are not supported by the references.
