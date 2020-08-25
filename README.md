# v2-nut-picker

[![Build Status](https://badgen.net/travis/cromarmot/v2-nut-picker/master)](https://travis-ci.com/cromarmot/v2-nut-picker)
[![NPM Download](https://badgen.net/npm/dm/@cromarmot/v2-nut-picker)](https://www.npmjs.com/package/@cromarmot/v2-nut-picker)
[![NPM Version](https://badge.fury.io/js/%40cromarmot%2Fv2-nut-picker.svg)](https://www.npmjs.com/package/@cromarmot/v2-nut-picker)
[![NPM License](https://badgen.net/npm/license/@cromarmot/v2-nut-picker)](https://github.com/cromarmot/v2-nut-picker/blob/master/LICENSE)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://github.com/cromarmot/v2-nut-picker/pulls)
[![Automated Release Notes by gren](https://img.shields.io/badge/%F0%9F%A4%96-release%20notes-00B2EE.svg)](https://github-tools.github.io/github-release-notes/)

vue2 mobile picker components modified based on nutui.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Install](#install)
- [Usage](#usage)
- [Links](#links)
- [Contributing](#contributing)
- [Contributors](#contributors)
- [License](#license)

## Introduction

[⬆ Back to Top](#table-of-contents)

## Features

Removed the title confirmation and cancel button, so you can use this components anywhere you want.

Optimize the part of the code written and fix some typo.

Add warning message in development environment.

Support mouse event on PC

[⬆ Back to Top](#table-of-contents)

## Install

`yarn add @cromarmot/v2-nut-picker`

[⬆ Back to Top](#table-of-contents)

## Usage

```
<template>
  <v2-nut-picker
    :list-data="listData"
    :default-value-data="defaultValue"
    @choose="choose"
  />
</template>

<script>
import V2NutPicker from '@cromarmot/v2-nut-picker'
export default {
  components: { V2NutPicker },
  data() {
    return {
      listData: [
        ['2020-01', '2020-02', '2020-03', '2020-04', '2020-05', '2020-06', '2020-07'],
        ['2020-01', '2020-02', '2020-03', '2020-04', '2020-05', '2020-06']
      ],
      defaultValue: [
        '2020-01',
        '2020-02'
      ]
    }
  },
  methods: {
    choose({ self, index, value, changeValueData }) {
      console.log(index, value, changeValueData)
      if (index === 0) {
        if (value > changeValueData[1]) {
          self.updateChooseValue(self, 1, value)
        }
      } else if (index === 1) {
        if (value < changeValueData[0]) {
          self.updateChooseValue(self, 0, value)
        }
      }
    }
  }
}
</script>
```

[⬆ Back to Top](#table-of-contents)

## Links

- [docs](https://cromarmot.github.io/v2-nut-picker/)

- [codesandbox.io](https://codesandbox.io/s/late-glade-eyqgw?file=/src/App.vue)

[⬆ Back to Top](#table-of-contents)

## Contributing

For those who are interested in contributing to this project, such as:

- report a bug
- request new feature
- fix a bug
- implement a new feature

Please refer to our [contributing guide](https://github.com/FEMessage/.github/blob/master/CONTRIBUTING.md).

[⬆ Back to Top](#table-of-contents)

## Contributors

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore -->
<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!

[⬆ Back to Top](#table-of-contents)

## License

[MIT](./LICENSE)

[⬆ Back to Top](#table-of-contents)

# Based on

https://github.com/FEMessage/vue-sfc-cli

https://github.com/jdf2e/nutui

https://github.com/jdf2e/nutui/tree/v2-dev/src/packages/picker
