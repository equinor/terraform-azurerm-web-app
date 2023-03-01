# Changelog

## [10.2.0](https://github.com/equinor/terraform-azurerm-web-app/compare/v10.1.1...v10.2.0) (2023-03-01)


### Features

* migrate to auth settings v2 ([#91](https://github.com/equinor/terraform-azurerm-web-app/issues/91)) ([7760734](https://github.com/equinor/terraform-azurerm-web-app/commit/7760734f755f2dc46daf19cd38a3297d70aff672))
* set diagnostic setting enabled log categories ([#87](https://github.com/equinor/terraform-azurerm-web-app/issues/87)) ([36d98bf](https://github.com/equinor/terraform-azurerm-web-app/commit/36d98bf386fe82d193dad9bde96995f57d03ed1e))


### Bug Fixes

* set diagnostic setting enabled log categories ([#89](https://github.com/equinor/terraform-azurerm-web-app/issues/89)) ([bed6174](https://github.com/equinor/terraform-azurerm-web-app/commit/bed61749e90e4609f373cfa707eba27d48617f77))

## [10.1.1](https://github.com/equinor/terraform-azurerm-web-app/compare/v10.1.0...v10.1.1) (2023-02-09)


### Bug Fixes

* explicitly disable diagnostic setting retention policy ([#84](https://github.com/equinor/terraform-azurerm-web-app/issues/84)) ([b167797](https://github.com/equinor/terraform-azurerm-web-app/commit/b16779793d27b40abf6254f2aa25c1743ded19b0))

## [10.1.0](https://github.com/equinor/terraform-azurerm-web-app/compare/v10.0.3...v10.1.0) (2023-02-09)


### Features

* set custom https logs values ([#73](https://github.com/equinor/terraform-azurerm-web-app/issues/73)) ([3d1e908](https://github.com/equinor/terraform-azurerm-web-app/commit/3d1e90803831cd2f85ab02677e70eb90403d16a0))
* set log analytics destination type and update min. provider version ([#81](https://github.com/equinor/terraform-azurerm-web-app/issues/81)) ([de76170](https://github.com/equinor/terraform-azurerm-web-app/commit/de76170d60828dacfbfbf46c779e52aa7444d49c))


### Bug Fixes

* set log analytics destination type to null ([#82](https://github.com/equinor/terraform-azurerm-web-app/issues/82)) ([6df59c7](https://github.com/equinor/terraform-azurerm-web-app/commit/6df59c7b3d62c7fe3932179d6b1c9f8cc84807ad))

## [10.0.3](https://github.com/equinor/terraform-azurerm-web-app/compare/v10.0.2...v10.0.3) (2023-01-13)


### Bug Fixes

* ignore changes to app settings ([#74](https://github.com/equinor/terraform-azurerm-web-app/issues/74)) ([579b872](https://github.com/equinor/terraform-azurerm-web-app/commit/579b872fb31c556f2f9f59150037e784510723a1))

## [10.0.2](https://github.com/equinor/terraform-azurerm-web-app/compare/v10.0.1...v10.0.2) (2023-01-13)


### Reverts

* set app settings ([#70](https://github.com/equinor/terraform-azurerm-web-app/issues/70)) ([19dd357](https://github.com/equinor/terraform-azurerm-web-app/commit/19dd3579f1afce3f8b1548aec6a3c458ae4894ff))

## [10.0.1](https://github.com/equinor/terraform-azurerm-web-app/compare/v10.0.0...v10.0.1) (2023-01-13)


### Bug Fixes

* disable auth settings by default ([#68](https://github.com/equinor/terraform-azurerm-web-app/issues/68)) ([7e41565](https://github.com/equinor/terraform-azurerm-web-app/commit/7e41565ffde940b1bb540882df96b7457ebe3adf))
* output null if identity not configured ([#67](https://github.com/equinor/terraform-azurerm-web-app/issues/67)) ([f741a22](https://github.com/equinor/terraform-azurerm-web-app/commit/f741a220daac309ac522260127feca76a52c7374))

## [10.0.0](https://github.com/equinor/terraform-azurerm-web-app/compare/v9.1.1...v10.0.0) (2023-01-13)


### ⚠ BREAKING CHANGES

* set app settings ([#66](https://github.com/equinor/terraform-azurerm-web-app/issues/66))
* change all occurences of service_plan to app_service_plan ([#65](https://github.com/equinor/terraform-azurerm-web-app/issues/65))
* update variables according to baseline ([#63](https://github.com/equinor/terraform-azurerm-web-app/issues/63))
* create multiple active directory auth settings ([#61](https://github.com/equinor/terraform-azurerm-web-app/issues/61))
* create single web app ([#59](https://github.com/equinor/terraform-azurerm-web-app/issues/59))
* combine app modules ([#56](https://github.com/equinor/terraform-azurerm-web-app/issues/56))

### Features

* create multiple active directory auth settings ([#61](https://github.com/equinor/terraform-azurerm-web-app/issues/61)) ([563961a](https://github.com/equinor/terraform-azurerm-web-app/commit/563961a6a30ed77d344b5af2eed674fbebfd9cd3)), closes [#48](https://github.com/equinor/terraform-azurerm-web-app/issues/48)
* create single web app ([#59](https://github.com/equinor/terraform-azurerm-web-app/issues/59)) ([f6ea572](https://github.com/equinor/terraform-azurerm-web-app/commit/f6ea572ba837a56f8d0012a8c5bdde0ff71f06d9))
* set app settings ([#66](https://github.com/equinor/terraform-azurerm-web-app/issues/66)) ([fb4ba88](https://github.com/equinor/terraform-azurerm-web-app/commit/fb4ba887af2c8dc7b2da41d7f5fb35f729646d64))


### Code Refactoring

* change all occurences of service_plan to app_service_plan ([#65](https://github.com/equinor/terraform-azurerm-web-app/issues/65)) ([f61e4a4](https://github.com/equinor/terraform-azurerm-web-app/commit/f61e4a4f3f7e4974fcb28ee84bbc21c1bf41c00c)), closes [#60](https://github.com/equinor/terraform-azurerm-web-app/issues/60)
* combine app modules ([#56](https://github.com/equinor/terraform-azurerm-web-app/issues/56)) ([a9531ab](https://github.com/equinor/terraform-azurerm-web-app/commit/a9531ab28cbb8b81bb244a667f398e480cbdf8e6))
* update variables according to baseline ([#63](https://github.com/equinor/terraform-azurerm-web-app/issues/63)) ([ad75198](https://github.com/equinor/terraform-azurerm-web-app/commit/ad7519878af3a45880f0514d3edf953456f8cb9e))
