#include QMK_KEYBOARD_H


// Each layer gets a name for readability, which is then used in the keymap matrix below.
// The underscores don't mean anything - you can have a layer called STUFF or any other name.
// Layer names don't all need to be of the same length, obviously, and you can also skip them
// entirely and just use numbers.
#define _QWERTY 0
#define _F_NUM 1
#define _OTHER 2

enum custom_keycodes {
  QWERTY = SAFE_RANGE,
  F_NUM,
  OTHER,
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

/* Qwerty
 * +------+------+------+------+------+------+------+------+------+------+------+------+
 * |  =   |  1   |  2   |  3   |  4   |  5   |  6   |  7   |  8   |  9   |  0   |  -   |
 * +------+------+------+------+------+------+------+------+------+------+------+------+
 * | Tab  |  Q   |  W   |  E   |  R   |  T   |  Y   |  U   |  I   |  O   |  P   |  \   |
 * +------+------+------+------+------+------+------+------+------+------+------+------+
 * |  E   |  A   |  S   |  D   |  F   |  G   |  H   |  J   |  K   |  L   |  S   |  Q   |
 * +------+------+------+------+------+------+------+------+------+------+------+------+
 * |Shift |  Z   |  X   |  C   |  V   |  B   |  N   |  M   |  ,   |  D   |  S   |Shift |
 * +------+------+------+------+------+------+------+------+------+------+------+------+
 * |  G   | n/a  | n/a  | n/a  | Del  |BkSpc |Space |Enter | n/a  |  [   |  ]   | n/a  |
 * +------+------+------+------+------+------+------+------+------+------+------+------+
 */
[_QWERTY] = LAYOUT(
    KC_EQL,       KC_1,         KC_2,         KC_3,  KC_4,   KC_5,       KC_6,       KC_7,   KC_8,    KC_9,           KC_0,            KC_MINS,
    KC_TAB,       KC_Q,         KC_W,         KC_E,  KC_R,   KC_T,       KC_Y,       KC_U,   KC_I,    KC_O,           KC_P,            KC_BSLS,
    LT(2,KC_ESC), KC_A,         KC_S,         KC_D,  KC_F,   LT(1,KC_G), LT(1,KC_H), KC_J,   KC_K,    KC_L,           LT(2,KC_SCLN),   RGUI_T(KC_QUOT),
    KC_LSFT,      LCTL_T(KC_Z), LALT_T(KC_X), KC_C,  KC_V,   KC_B,       KC_N,       KC_M,   KC_COMM, RALT_T(KC_DOT), RCTL_T(KC_SLSH), KC_RSFT,
    LT(1,KC_GRV), KC_NO,        KC_NO,        KC_NO, KC_DEL, KC_BSPC,    KC_SPC,     KC_ENT, KC_NO,   KC_LBRC,        KC_RBRC,         KC_NO
),

/* F Keys & Numpad
 * +------+------+------+------+------+------+------+------+------+------+------+------+
 * |      |  F1  |  F2  |  F3  |  F4  |  F5  |  F6  |  F7  |  F8  |  F9  | F10  | F11  |
 * +------+------+------+------+------+------+------+------+------+------+------+------+
 * | n/a  |  E   |  A   |  L   |  R   |  P   |      | KP 7 | KP 8 | KP 9 |      | F12  |
 * +------+------+------+------+------+------+------+------+------+------+------+------+
 * | n/a  |  H   |  D   |  L   |  R   |  `   | n/a  | KP 4 | KP 5 | KP 6 |      | n/a  |
 * +------+------+------+------+------+------+------+------+------+------+------+------+
 * | n/a  |  P   |  C   |  [   |  ]   |  T   | n/a  | KP 1 | KP 2 | KP 3 |      | n/a  |
 * +------+------+------+------+------+------+------+------+------+------+------+------+
 * | n/a  |  A   |      | n/a  | n/a  | n/a  | n/a  | KP 0 | KP 0 | KP . |      | n/a  |
 * +------+------+------+------+------+------+------+------+------+------+------+------+
 */
[_F_NUM] = LAYOUT(
    KC_CAPS, KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,   KC_F6,   KC_F7, KC_F8, KC_F9,   KC_F10,  KC_F11,
    KC_NO,   KC_EXLM, KC_AT,   KC_LCBR, KC_RCBR, KC_PIPE, KC_PAST, KC_P7, KC_P8, KC_P9,   KC_PMNS, KC_F12,
    KC_NO,   KC_HASH, KC_DLR,  KC_LPRN, KC_RPRN, KC_GRV,  KC_NO,   KC_P4, KC_P5, KC_P6,   KC_PPLS, KC_NO,
    KC_NO,   KC_PERC, KC_CIRC, KC_LBRC, KC_RBRC, KC_TILD, KC_NO,   KC_P1, KC_P2, KC_P3,   KC_PSLS, KC_NO,
    KC_NO,   KC_AMPR, KC_PCMM, KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_P0, KC_P0, KC_PDOT, KC_PEQL, KC_NO
),

/* Other
 * +------+------+------+------+------+------+------+------+------+------+------+------+
 * |BL_TOG|RGB_TO| n/a  | n/a  | n/a  | n/a  | n/a  | n/a  | n/a  | n/a  | n/a  |QK_BOO|
 * +------+------+------+------+------+------+------+------+------+------+------+------+
 * |BL_OFF| n/a  | n/a  |  M   | n/a  | n/a  | n/a  | n/a  | n/a  | n/a  | n/a  | n/a  |
 * +------+------+------+------+------+------+------+------+------+------+------+------+
 * | n/a  | n/a  |  M   |  M   |  M   | n/a  |      |      |      |      | n/a  |      |
 * +------+------+------+------+------+------+------+------+------+------+------+------+
 * | n/a  | n/a  | n/a  | n/a  | n/a  | n/a  | n/a  | n/a  |      |      | n/a  | n/a  |
 * +------+------+------+------+------+------+------+------+------+------+------+------+
 * | n/a  | n/a  | n/a  | n/a  |  B   |  B   | n/a  |      |      | Mute | n/a  | n/a  |
 * +------+------+------+------+------+------+------+------+------+------+------+------+
 */
[_OTHER] = LAYOUT(
BL_TOGG, RGB_TOG, KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO, QK_BOOT,
BL_OFF,  KC_NO,   KC_NO,   KC_MS_U, KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO, KC_NO,
KC_NO,   KC_NO,   KC_MS_L, KC_MS_D, KC_MS_R, KC_NO,   KC_LEFT, KC_DOWN, KC_UP,   KC_RGHT, KC_NO, KC_MPLY,
KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_MPRV, KC_MNXT, KC_NO, KC_NO,
KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_BTN1, KC_BTN2, KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO, KC_NO
),


};

#ifdef AUDIO_ENABLE
float tone_qwerty[][2]     = SONG(QWERTY_SOUND);
#endif

void persistent_default_layer_set(uint16_t default_layer) {
  eeconfig_update_default_layer(default_layer);
  default_layer_set(default_layer);
}

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  switch (keycode) {
    case QWERTY:
      if (record->event.pressed) {
        #ifdef AUDIO_ENABLE
          PLAY_SONG(tone_qwerty);
        #endif
        persistent_default_layer_set(1UL<<_QWERTY);
      }
      return false;
      break;
  }
  return true;
}
