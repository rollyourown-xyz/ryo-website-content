---
title: "Inlife"
draft: false
---
<!--
SPDX-FileCopyrightText: 2022 Wilfred Nicoll <xyzroller@rollyourown.xyz>
SPDX-License-Identifier: CC-BY-SA-4.0
-->

## Inlife procedures

Our automation code takes care of [upgrading](/rollyourown/how_to_use/maintain/#upgrading-a-project-deployment) your project's components as well as [backing them up](/rollyourown/how_to_use/back_up_and_restore/#how-to-back-up) and, if needed, [restoring](/rollyourown/how_to_use/back_up_and_restore/#how-to-restore). A rollyourown project provides four additional scripts to manage your project over time:

- `./upgrade.sh` - Upgrades the project by building new images and replacing the deployed containers
- `./rollback.sh` - Rolls back to a previous working version in case an upgrade fails
- `./backup.sh` - Backs up the project by backing up the deployed containers' persistent storage
- `./restore.sh` - Restores the project, if necessary, from a backup
