# Changelog

## [15.1.1](https://github.com/equinor/terraform-azurerm-web-app/compare/v15.1.0...v15.1.1) (2024-03-11)


### Bug Fixes

* prevent configuration of HTTP logging using app settings ([#172](https://github.com/equinor/terraform-azurerm-web-app/issues/172)) ([4884652](https://github.com/equinor/terraform-azurerm-web-app/commit/4884652b6232c08d115e482d26f7ac35201bbc19))

## [15.1.0](https://github.com/equinor/terraform-azurerm-web-app/compare/v15.0.0...v15.1.0) (2024-03-11)


### Features

* add service tag possibility ([#169](https://github.com/equinor/terraform-azurerm-web-app/issues/169)) ([25d02c4](https://github.com/equinor/terraform-azurerm-web-app/commit/25d02c4aa4305c95a5be749e59dceaead0b74218))

## [15.0.0](https://github.com/equinor/terraform-azurerm-web-app/compare/v14.4.0...v15.0.0) (2024-02-29)


### ⚠ BREAKING CHANGES

* Remove `lifecycle.ignore_changes` for `azurerm_linux_web_app.this.app_settings` and `azurerm_windows_web_app.this.app_settings`. To migrate your project, configure app settings for your web app using the `app_settings` variable. Consider using App Configuration references and Key Vault references to continue manage settings outside of Terraform.

### Features

* configure Docker registry settings ([#166](https://github.com/equinor/terraform-azurerm-web-app/issues/166)) ([4e75f0f](https://github.com/equinor/terraform-azurerm-web-app/commit/4e75f0f209bff57a293898ef214e117f747b6559))


### Code Refactoring

* strict configuration of app settings ([#167](https://github.com/equinor/terraform-azurerm-web-app/issues/167)) ([f682c78](https://github.com/equinor/terraform-azurerm-web-app/commit/f682c7872da15afa02451ada39fa4b2e4bd2e847))

## [14.4.0](https://github.com/equinor/terraform-azurerm-web-app/compare/v14.3.0...v14.4.0) (2024-02-26)


### Features

* add application stack variable ([#160](https://github.com/equinor/terraform-azurerm-web-app/issues/160)) ([30b85b5](https://github.com/equinor/terraform-azurerm-web-app/commit/30b85b5050936680a11ba105b96e4527df760473))
* add custom domain verification ID output ([8d48b60](https://github.com/equinor/terraform-azurerm-web-app/commit/8d48b60260de42f1d4cbc67b93e518d620fd6ad7))
* added default hostname to outputs ([#163](https://github.com/equinor/terraform-azurerm-web-app/issues/163)) ([27522f9](https://github.com/equinor/terraform-azurerm-web-app/commit/27522f93c7708344aa4b409e6c9d10c6259b701e))
* manage app settings ([#164](https://github.com/equinor/terraform-azurerm-web-app/issues/164)) ([0df5c30](https://github.com/equinor/terraform-azurerm-web-app/commit/0df5c3050135db2c3b5783206cc78144df21f47d))
* variable for diagnostic setting metric ([#161](https://github.com/equinor/terraform-azurerm-web-app/issues/161)) ([4c52611](https://github.com/equinor/terraform-azurerm-web-app/commit/4c52611443b409b1148d833b90344575e86b599c))

## [14.3.0](https://github.com/equinor/terraform-azurerm-web-app/compare/v14.2.0...v14.3.0) (2024-01-25)


### Features

* add variable `diagnostic_setting_name` ([#154](https://github.com/equinor/terraform-azurerm-web-app/issues/154)) ([6642c12](https://github.com/equinor/terraform-azurerm-web-app/commit/6642c12d319b7cc60f71c6f729d604ebd35670fa))

## [14.2.0](https://github.com/equinor/terraform-azurerm-web-app/compare/v14.1.1...v14.2.0) (2024-01-25)


### Features

* add variable `active_directory_tenant_auth_endpoint` ([#149](https://github.com/equinor/terraform-azurerm-web-app/issues/149)) ([e7177c1](https://github.com/equinor/terraform-azurerm-web-app/commit/e7177c1fdc3d0c0aa25df1595df37d164915020d))
* add variable `always_on` ([#150](https://github.com/equinor/terraform-azurerm-web-app/issues/150)) ([3f4dfd0](https://github.com/equinor/terraform-azurerm-web-app/commit/3f4dfd080a79763b1f8f347d554af269b60b02a7))
* add variable `app_settings` ([#151](https://github.com/equinor/terraform-azurerm-web-app/issues/151)) ([8d43ad9](https://github.com/equinor/terraform-azurerm-web-app/commit/8d43ad9182d8f6d0ba286cc085fc046df18b2746))
* add variable `ip_restrictions` ([#152](https://github.com/equinor/terraform-azurerm-web-app/issues/152)) ([17d9837](https://github.com/equinor/terraform-azurerm-web-app/commit/17d983700bada210420f9a7e60b0ed78b1df2dff))

## [14.1.1](https://github.com/equinor/terraform-azurerm-web-app/compare/v14.1.0...v14.1.1) (2023-12-20)


### Bug Fixes

* remove diagnostic setting retention policies ([#146](https://github.com/equinor/terraform-azurerm-web-app/issues/146)) ([aee0f62](https://github.com/equinor/terraform-azurerm-web-app/commit/aee0f628156f24c126dd20b39bc6decd00e6ecb8))

## [14.1.0](https://github.com/equinor/terraform-azurerm-web-app/compare/v14.0.1...v14.1.0) (2023-12-05)


### Features

* auto use managed identity for container registry ([#141](https://github.com/equinor/terraform-azurerm-web-app/issues/141)) ([cd2d203](https://github.com/equinor/terraform-azurerm-web-app/commit/cd2d20302ce11d8aa95029ae2130574143212e3d))

## [14.0.1](https://github.com/equinor/terraform-azurerm-web-app/compare/v14.0.0...v14.0.1) (2023-12-01)


### Bug Fixes

* correct tenant auth endpoint ([#139](https://github.com/equinor/terraform-azurerm-web-app/issues/139)) ([956f9f5](https://github.com/equinor/terraform-azurerm-web-app/commit/956f9f5fe0dfcc9b6cde14185e9c264a2f9acd80))

## [14.0.0](https://github.com/equinor/terraform-azurerm-web-app/compare/v13.2.0...v14.0.0) (2023-12-01)


### ⚠ BREAKING CHANGES

* remove variables `auth_settings_enabled` and `auth_settings_active_directory`, add variables `active_directory_client_id` and `active_directory_client_secret_setting_name`.

### Features

* migrate to auth settings V2 ([#136](https://github.com/equinor/terraform-azurerm-web-app/issues/136)) ([5772e14](https://github.com/equinor/terraform-azurerm-web-app/commit/5772e145dbdfe35d1865dca3945e7c2ee6f9c3d1))


### Bug Fixes

* enabling auth settings breaks website ([#138](https://github.com/equinor/terraform-azurerm-web-app/issues/138)) ([97620eb](https://github.com/equinor/terraform-azurerm-web-app/commit/97620eb1b5b034cad46b7b33b8a6f79c607a114d))

## [13.2.0](https://github.com/equinor/terraform-azurerm-web-app/compare/v13.1.2...v13.2.0) (2023-11-08)


### Features

* add variables ([#132](https://github.com/equinor/terraform-azurerm-web-app/issues/132)) ([c622629](https://github.com/equinor/terraform-azurerm-web-app/commit/c6226293baff020736ee69f73c8febb7a59fa398))

## [13.1.2](https://github.com/equinor/terraform-azurerm-web-app/compare/v13.1.1...v13.1.2) (2023-10-06)


### Bug Fixes

* remove unused variable ([#130](https://github.com/equinor/terraform-azurerm-web-app/issues/130)) ([afa84be](https://github.com/equinor/terraform-azurerm-web-app/commit/afa84be083bdff2be4dea06cd0b6a79030cf844a))

## [13.1.1](https://github.com/equinor/terraform-azurerm-web-app/compare/v13.1.0...v13.1.1) (2023-09-27)


### Bug Fixes

* user-assigned identities not being assigned ([#127](https://github.com/equinor/terraform-azurerm-web-app/issues/127)) ([62c053f](https://github.com/equinor/terraform-azurerm-web-app/commit/62c053f2b580f18328c065ad2500add5b0babc74))

## [13.1.0](https://github.com/equinor/terraform-azurerm-web-app/compare/v13.0.0...v13.1.0) (2023-09-08)


### Features

* auto assign Key Vault reference identity ID ([#124](https://github.com/equinor/terraform-azurerm-web-app/issues/124)) ([4675b7a](https://github.com/equinor/terraform-azurerm-web-app/commit/4675b7a39d6e6d03ac4bf9746f522247ea823657))

## [13.0.0](https://github.com/equinor/terraform-azurerm-web-app/compare/v12.0.0...v13.0.0) (2023-07-26)


### ⚠ BREAKING CHANGES

* remove variable `identity`, add variables `system_assigned_identity_enabled` and `identity_ids`.
* variable `custom_hostnames` renamed to `custom_hostname_bindings` and type changed from `list` to `map`.

### Bug Fixes

* don't specify Log Analytics destination type ([#121](https://github.com/equinor/terraform-azurerm-web-app/issues/121)) ([2d5614c](https://github.com/equinor/terraform-azurerm-web-app/commit/2d5614c4c5d9a8b9fd6a2957fe3d7c658bef66d7))
* ignore changes to application logs ([#114](https://github.com/equinor/terraform-azurerm-web-app/issues/114)) ([e848a8a](https://github.com/equinor/terraform-azurerm-web-app/commit/e848a8a2a2a42f8541ac8d86e51a6b31bfbf5f2e))
* only configure auth settings when enabled ([#113](https://github.com/equinor/terraform-azurerm-web-app/issues/113)) ([168701d](https://github.com/equinor/terraform-azurerm-web-app/commit/168701d230373d7cea74a4c6352f5d9c6ab6e74d))


### Code Refactoring

* follow variable best practices ([#115](https://github.com/equinor/terraform-azurerm-web-app/issues/115)) ([a2039a1](https://github.com/equinor/terraform-azurerm-web-app/commit/a2039a1c11c972ab7ea99c25699db93309733cdc))
* simplify identity configuration ([#122](https://github.com/equinor/terraform-azurerm-web-app/issues/122)) ([6f379d2](https://github.com/equinor/terraform-azurerm-web-app/commit/6f379d23d764735de297591272e585d0685531f2))

## [12.0.0](https://github.com/equinor/terraform-azurerm-web-app/compare/v11.3.1...v12.0.0) (2023-06-30)


### ⚠ BREAKING CHANGES

* change variable `custom_hostnames` type

### Features

* specify custom hostname binding type ([#111](https://github.com/equinor/terraform-azurerm-web-app/issues/111)) ([2468472](https://github.com/equinor/terraform-azurerm-web-app/commit/2468472b20a3e8cf0fb21bafbb0240192627716e))

## [11.3.1](https://github.com/equinor/terraform-azurerm-web-app/compare/v11.3.0...v11.3.1) (2023-06-19)


### Bug Fixes

* ignore changes to application logs ([#109](https://github.com/equinor/terraform-azurerm-web-app/issues/109)) ([33bd0b2](https://github.com/equinor/terraform-azurerm-web-app/commit/33bd0b28e44ab6be5340d0a673a665d4c7bc9d39))

## [11.3.0](https://github.com/equinor/terraform-azurerm-web-app/compare/v11.2.0...v11.3.0) (2023-05-24)


### Features

* add vnet route all enabled variable ([#107](https://github.com/equinor/terraform-azurerm-web-app/issues/107)) ([80e4de1](https://github.com/equinor/terraform-azurerm-web-app/commit/80e4de11d132cd6272029da5f6abe7221215d981))

## [11.2.0](https://github.com/equinor/terraform-azurerm-web-app/compare/v11.1.0...v11.2.0) (2023-05-08)


### Features

* enable application logs ([#105](https://github.com/equinor/terraform-azurerm-web-app/issues/105)) ([7dbe4c8](https://github.com/equinor/terraform-azurerm-web-app/commit/7dbe4c8fda878c2d294d59b47bfbd526a52c103d))

## [11.1.0](https://github.com/equinor/terraform-azurerm-web-app/compare/v11.0.0...v11.1.0) (2023-04-27)


### Features

* configure vnet integration ([#103](https://github.com/equinor/terraform-azurerm-web-app/issues/103)) ([600f5b6](https://github.com/equinor/terraform-azurerm-web-app/commit/600f5b6817db4ab18586b808f6e7550074ece618))

## [11.0.0](https://github.com/equinor/terraform-azurerm-web-app/compare/v10.2.2...v11.0.0) (2023-04-20)


### ⚠ BREAKING CHANGES

* submodule `app` is now main module

### Code Refactoring

* 1-to-1 mapping of modules-to-resources ([#100](https://github.com/equinor/terraform-azurerm-web-app/issues/100)) ([280b731](https://github.com/equinor/terraform-azurerm-web-app/commit/280b73173b6e47b423987f6cecdd08134391519d))

## [10.2.2](https://github.com/equinor/terraform-azurerm-web-app/compare/v10.2.1...v10.2.2) (2023-03-03)


### Reverts

* migrate to auth settings v2 ([#95](https://github.com/equinor/terraform-azurerm-web-app/issues/95)) ([48379cf](https://github.com/equinor/terraform-azurerm-web-app/commit/48379cf5d60035ec0d9caee5699214333b01f8c8))

## [10.2.1](https://github.com/equinor/terraform-azurerm-web-app/compare/v10.2.0...v10.2.1) (2023-03-02)


### Bug Fixes

* auth settings redirect to blank page ([#92](https://github.com/equinor/terraform-azurerm-web-app/issues/92)) ([1fbd747](https://github.com/equinor/terraform-azurerm-web-app/commit/1fbd74735f3f70725e4017522c5c975f139d38ca))

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
