___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Convert Consent State to Granted/Denied",
  "categories": ["UTILITY", "TAG_MANAGEMENT"],
  "description": "converts any given input consent state from your CMP's syntax to the GTM-syntax of granted/denied",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "originalConsentValue",
    "displayName": "Original Consent Value",
    "simpleValueType": true,
    "alwaysInSummary": true
  },
  {
    "type": "RADIO",
    "name": "equivalentLookup",
    "displayName": "Type of \"granted\" Equivalent",
    "radioItems": [
      {
        "value": "booleanEquivalent",
        "displayValue": "Boolean",
        "help": "converts true to \"granted\" and false to \"denied\""
      },
      {
        "value": "customEquivalent",
        "displayValue": "Custom",
        "help": "converts any custom value that you set to \"granted\" and all others to \"denied\""
      }
    ],
    "simpleValueType": true
  },
  {
    "type": "TEXT",
    "name": "customEquivalent",
    "displayName": "custom equivalent of value of granted consent",
    "simpleValueType": true,
    "enablingConditions": [
      {
        "paramName": "equivalentLookup",
        "paramValue": "customEquivalent",
        "type": "EQUALS"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

// Enter your template code here.
const log = require('logToConsole');
log('data =', data);

if (data.equivalentLookup === "booleanEquivalent") {
  if (data.originalConsentValue) {
    return "granted";
  }
  return "denied";
}

if (data.originalConsentValue && data.originalConsentValue === data.customEquivalent) {
  return "granted";
}

// Variables must return a value.
return "denied";


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: boolean // granted
  code: |-
    const mockData = {
      originalConsentValue: true,
      equivalentLookup: "booleanEquivalent",
      customEquivalent: "none",
    };

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isEqualTo("granted");
- name: boolean // denied
  code: |-
    const mockData = {
      originalConsentValue: false,
      equivalentLookup: "booleanEquivalent",
      customEquivalent: "none",
    };

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isEqualTo("denied");
- name: custom // granted
  code: |-
    const mockData = {
      originalConsentValue: "1",
      equivalentLookup: "customEquivalent",
      customEquivalent: "1",
    };

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isEqualTo("granted");
- name: input empty // denied
  code: |-
    const mockData = {
      originalConsentValue: undefined,
      equivalentLookup: "customEquivalent",
      customEquivalent: "1",
    };

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isEqualTo("denied");


___NOTES___

Created on 28/05/2021, 15:29:43


