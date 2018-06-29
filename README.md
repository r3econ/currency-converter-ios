![Platform](https://img.shields.io/badge/platform-ios-lightgrey.svg)
[![Build Status](https://travis-ci.org/r3econ/currency-converter-ios.svg?branch=master)](https://travis-ci.org/r3econ/currency-converter-ios)
[![Maintainability](https://api.codeclimate.com/v1/badges/990eaadfc25a0421a60d/maintainability)](https://codeclimate.com/github/r3econ/currency-converter-ios/maintainability)
[![saythanks.io](https://img.shields.io/badge/saythanks.io-now-1EAEDB.svg)](https://saythanks.io/to/r3econ)

# Currency Converter

`iOS` app showing most recent exchange rates for major currency pairs. The app fetches current exchange rates from public [European Central Bank API](https://exchangeratesapi.io/). Price is updated every `60s`.

## What it does?
First user enters price and selects base currency. Then, the app shows the price converted to other currencies.
Exchange rates are checked and updated every minute.

![Screenshot](https://i.imgur.com/hoMzGimh.png)

# Technologies used
- Swift
- URLSession
- JSONDecoder
- Timer

# Architecture

The app uses standard vanilla Model View Controller architecture which is a golden standard for iOS apps.

![Architecture](https://i.imgur.com/GJq0tXT.png)

# License

Copyright (c) 2018 Rafał Sroka
