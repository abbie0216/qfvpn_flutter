import 'package:flutter/widgets.dart';

class R {
  static const image = _R_Image();
  static const color = _R_Color();
}

/** transparent:
    0% – 00
    5% – 0D
    10% – 1A
    15% – 26
    20% – 33
    25% – 40
    30% – 4D
    35% – 49
    40% – 66
    45% – 73
    50% – 80
    55% – 8C
    60% – 99
    65% – A6
    70% – B3
    75% – BF
    80% – CC
    85% – D9
    90% – E6
    95% – F2
    100% – FF
 **/

class _R_Color {
  const _R_Color();

  Color btn_white_color() => Color(0xFFf4f6f9);
  Color btn_blue_color() => Color(0xFF6569ee);
  Color text_blue_color() => Color(0xff6569ee);

  Color text_field_border_color() => Color(0xffdddeec);

  Color background_color() => Color(0xfff4f6f9);

  Color login_bg_color() => Color(0xff6569ee);
  Color login_hint_color() => Color(0x66FFFFFF);
  Color logo_bg_color() => Color(0xFFCFD1FF);

  Color home_logo_text() => Color(0xff6569ee);
  Color home_announce_text() => Color(0x66000000);
  Color home_announce_bg_shadow() => Color(0x80ffffff);

  Color forgot_hint_color() => Color(0x33000000);

}

class _R_Image {
  const _R_Image();

  final asset = const _R_Image_AssetResource();

  /// asset: assets/images/btn_back_n.png
  AssetImage btn_back_n() {
    return AssetImage(asset.btn_back_n.keyName);
  }

  /// asset: assets/images/btn_back_p.png
  AssetImage btn_back_p() {
    return AssetImage(asset.btn_back_p.keyName);
  }

  /// asset: assets/images/btn_back_white_n.png
  AssetImage btn_back_white_n() {
    return AssetImage(asset.btn_back_white_n.keyName);
  }

  /// asset: assets/images/btn_back_white_p.png
  AssetImage btn_back_white_p() {
    return AssetImage(asset.btn_back_white_p.keyName);
  }

  /// asset: assets/images/btn_camera_n.png
  AssetImage btn_camera_n() {
    return AssetImage(asset.btn_camera_n.keyName);
  }

  /// asset: assets/images/btn_camera_p.png
  AssetImage btn_camera_p() {
    return AssetImage(asset.btn_camera_p.keyName);
  }

  /// asset: assets/images/btn_close_n.png
  AssetImage btn_close_n() {
    return AssetImage(asset.btn_close_n.keyName);
  }

  /// asset: assets/images/btn_close_p.png
  AssetImage btn_close_p() {
    return AssetImage(asset.btn_close_p.keyName);
  }

  /// asset: assets/images/btn_copy_n.png
  AssetImage btn_copy_n() {
    return AssetImage(asset.btn_copy_n.keyName);
  }

  /// asset: assets/images/btn_copy_p.png
  AssetImage btn_copy_p() {
    return AssetImage(asset.btn_copy_p.keyName);
  }

  /// asset: assets/images/btn_dropdown_n.png
  AssetImage btn_dropdown_n() {
    return AssetImage(asset.btn_dropdown_n.keyName);
  }

  /// asset: assets/images/btn_dropdown_p.png
  AssetImage btn_dropdown_p() {
    return AssetImage(asset.btn_dropdown_p.keyName);
  }

  /// asset: assets/images/btn_history_n.png
  AssetImage btn_history_n() {
    return AssetImage(asset.btn_history_n.keyName);
  }

  /// asset: assets/images/btn_history_p.png
  AssetImage btn_history_p() {
    return AssetImage(asset.btn_history_p.keyName);
  }

  /// asset: assets/images/btn_imgdelete_n.png
  AssetImage btn_imgdelete_n() {
    return AssetImage(asset.btn_imgdelete_n.keyName);
  }

  /// asset: assets/images/btn_imgdelete_p.png
  AssetImage btn_imgdelete_p() {
    return AssetImage(asset.btn_imgdelete_p.keyName);
  }

  /// asset: assets/images/btn_next_n.png
  AssetImage btn_next_n() {
    return AssetImage(asset.btn_next_n.keyName);
  }

  /// asset: assets/images/btn_next_p.png
  AssetImage btn_next_p() {
    return AssetImage(asset.btn_next_p.keyName);
  }

  /// asset: assets/images/btn_next_white_n.png
  AssetImage btn_next_white_n() {
    return AssetImage(asset.btn_next_white_n.keyName);
  }

  /// asset: assets/images/btn_next_white_p.png
  AssetImage btn_next_white_p() {
    return AssetImage(asset.btn_next_white_p.keyName);
  }

  /// asset: assets/images/btn_notgood_n.png
  AssetImage btn_notgood_n() {
    return AssetImage(asset.btn_notgood_n.keyName);
  }

  /// asset: assets/images/btn_notgood_p.png
  AssetImage btn_notgood_p() {
    return AssetImage(asset.btn_notgood_p.keyName);
  }

  /// asset: assets/images/btn_radio_n.png
  AssetImage btn_radio_n() {
    return AssetImage(asset.btn_radio_n.keyName);
  }

  /// asset: assets/images/btn_radio_p.png
  AssetImage btn_radio_p() {
    return AssetImage(asset.btn_radio_p.keyName);
  }

  /// asset: assets/images/btn_setting_n.png
  AssetImage btn_setting_n() {
    return AssetImage(asset.btn_setting_n.keyName);
  }

  /// asset: assets/images/btn_setting_p.png
  AssetImage btn_setting_p() {
    return AssetImage(asset.btn_setting_p.keyName);
  }

  /// asset: assets/images/btn_share_n.png
  AssetImage btn_share_n() {
    return AssetImage(asset.btn_share_n.keyName);
  }

  /// asset: assets/images/btn_share_p.png
  AssetImage btn_share_p() {
    return AssetImage(asset.btn_share_p.keyName);
  }

  /// asset: assets/images/btn_sogood_n.png
  AssetImage btn_sogood_n() {
    return AssetImage(asset.btn_sogood_n.keyName);
  }

  /// asset: assets/images/btn_sogood_p.png
  AssetImage btn_sogood_p() {
    return AssetImage(asset.btn_sogood_p.keyName);
  }

  /// asset: assets/images/btn_soso_n.png
  AssetImage btn_soso_n() {
    return AssetImage(asset.btn_soso_n.keyName);
  }

  /// asset: assets/images/btn_soso_p.png
  AssetImage btn_soso_p() {
    return AssetImage(asset.btn_soso_p.keyName);
  }

  /// asset: assets/images/ellipse_11.png
  AssetImage ellipse_11() {
    return AssetImage(asset.ellipse_11.keyName);
  }

  /// asset: assets/images/eye.png
  AssetImage eye() {
    return AssetImage(asset.eye.keyName);
  }

  /// asset: assets/images/eye_slash.png
  AssetImage eye_slash() {
    return AssetImage(asset.eye_slash.keyName);
  }

  /// asset: assets/images/flag_albania.png
  AssetImage flag_albania() {
    return AssetImage(asset.flag_albania.keyName);
  }

  /// asset: assets/images/flag_america.png
  AssetImage flag_america() {
    return AssetImage(asset.flag_america.keyName);
  }

  /// asset: assets/images/flag_american_samoa.png
  AssetImage flag_american_samoa() {
    return AssetImage(asset.flag_american_samoa.keyName);
  }

  /// asset: assets/images/flag_andorra.png
  AssetImage flag_andorra() {
    return AssetImage(asset.flag_andorra.keyName);
  }

  /// asset: assets/images/flag_argentina.png
  AssetImage flag_argentina() {
    return AssetImage(asset.flag_argentina.keyName);
  }

  /// asset: assets/images/flag_aruba.png
  AssetImage flag_aruba() {
    return AssetImage(asset.flag_aruba.keyName);
  }

  /// asset: assets/images/flag_austria.png
  AssetImage flag_austria() {
    return AssetImage(asset.flag_austria.keyName);
  }

  /// asset: assets/images/flag_auto.png
  AssetImage flag_auto() {
    return AssetImage(asset.flag_auto.keyName);
  }

  /// asset: assets/images/flag_bahamas.png
  AssetImage flag_bahamas() {
    return AssetImage(asset.flag_bahamas.keyName);
  }

  /// asset: assets/images/flag_belarus.png
  AssetImage flag_belarus() {
    return AssetImage(asset.flag_belarus.keyName);
  }

  /// asset: assets/images/flag_belgium.png
  AssetImage flag_belgium() {
    return AssetImage(asset.flag_belgium.keyName);
  }

  /// asset: assets/images/flag_bermuda.png
  AssetImage flag_bermuda() {
    return AssetImage(asset.flag_bermuda.keyName);
  }

  /// asset: assets/images/flag_bolivia.png
  AssetImage flag_bolivia() {
    return AssetImage(asset.flag_bolivia.keyName);
  }

  /// asset: assets/images/flag_brazil.png
  AssetImage flag_brazil() {
    return AssetImage(asset.flag_brazil.keyName);
  }

  /// asset: assets/images/flag_bulgaria.png
  AssetImage flag_bulgaria() {
    return AssetImage(asset.flag_bulgaria.keyName);
  }

  /// asset: assets/images/flag_cambodia.png
  AssetImage flag_cambodia() {
    return AssetImage(asset.flag_cambodia.keyName);
  }

  /// asset: assets/images/flag_canada.png
  AssetImage flag_canada() {
    return AssetImage(asset.flag_canada.keyName);
  }

  /// asset: assets/images/flag_cayman_islands.png
  AssetImage flag_cayman_islands() {
    return AssetImage(asset.flag_cayman_islands.keyName);
  }

  /// asset: assets/images/flag_chile.png
  AssetImage flag_chile() {
    return AssetImage(asset.flag_chile.keyName);
  }

  /// asset: assets/images/flag_china.png
  AssetImage flag_china() {
    return AssetImage(asset.flag_china.keyName);
  }

  /// asset: assets/images/flag_colombia.png
  AssetImage flag_colombia() {
    return AssetImage(asset.flag_colombia.keyName);
  }

  /// asset: assets/images/flag_costa_rica.png
  AssetImage flag_costa_rica() {
    return AssetImage(asset.flag_costa_rica.keyName);
  }

  /// asset: assets/images/flag_cuba.png
  AssetImage flag_cuba() {
    return AssetImage(asset.flag_cuba.keyName);
  }

  /// asset: assets/images/flag_czech_republic.png
  AssetImage flag_czech_republic() {
    return AssetImage(asset.flag_czech_republic.keyName);
  }

  /// asset: assets/images/flag_denmark.png
  AssetImage flag_denmark() {
    return AssetImage(asset.flag_denmark.keyName);
  }

  /// asset: assets/images/flag_dominican_republic.png
  AssetImage flag_dominican_republic() {
    return AssetImage(asset.flag_dominican_republic.keyName);
  }

  /// asset: assets/images/flag_ecuador.png
  AssetImage flag_ecuador() {
    return AssetImage(asset.flag_ecuador.keyName);
  }

  /// asset: assets/images/flag_egypt.png
  AssetImage flag_egypt() {
    return AssetImage(asset.flag_egypt.keyName);
  }

  /// asset: assets/images/flag_estonia.png
  AssetImage flag_estonia() {
    return AssetImage(asset.flag_estonia.keyName);
  }

  /// asset: assets/images/flag_falkland_islands.png
  AssetImage flag_falkland_islands() {
    return AssetImage(asset.flag_falkland_islands.keyName);
  }

  /// asset: assets/images/flag_faroe_islands.png
  AssetImage flag_faroe_islands() {
    return AssetImage(asset.flag_faroe_islands.keyName);
  }

  /// asset: assets/images/flag_finland.png
  AssetImage flag_finland() {
    return AssetImage(asset.flag_finland.keyName);
  }

  /// asset: assets/images/flag_france.png
  AssetImage flag_france() {
    return AssetImage(asset.flag_france.keyName);
  }

  /// asset: assets/images/flag_germany.png
  AssetImage flag_germany() {
    return AssetImage(asset.flag_germany.keyName);
  }

  /// asset: assets/images/flag_gibraltar.png
  AssetImage flag_gibraltar() {
    return AssetImage(asset.flag_gibraltar.keyName);
  }

  /// asset: assets/images/flag_greece.png
  AssetImage flag_greece() {
    return AssetImage(asset.flag_greece.keyName);
  }

  /// asset: assets/images/flag_greenland.png
  AssetImage flag_greenland() {
    return AssetImage(asset.flag_greenland.keyName);
  }

  /// asset: assets/images/flag_grenada.png
  AssetImage flag_grenada() {
    return AssetImage(asset.flag_grenada.keyName);
  }

  /// asset: assets/images/flag_guatemala.png
  AssetImage flag_guatemala() {
    return AssetImage(asset.flag_guatemala.keyName);
  }

  /// asset: assets/images/flag_guernsey.png
  AssetImage flag_guernsey() {
    return AssetImage(asset.flag_guernsey.keyName);
  }

  /// asset: assets/images/flag_guyana.png
  AssetImage flag_guyana() {
    return AssetImage(asset.flag_guyana.keyName);
  }

  /// asset: assets/images/flag_haiti.png
  AssetImage flag_haiti() {
    return AssetImage(asset.flag_haiti.keyName);
  }

  /// asset: assets/images/flag_hawaii.png
  AssetImage flag_hawaii() {
    return AssetImage(asset.flag_hawaii.keyName);
  }

  /// asset: assets/images/flag_honduras.png
  AssetImage flag_honduras() {
    return AssetImage(asset.flag_honduras.keyName);
  }

  /// asset: assets/images/flag_hong_kong.png
  AssetImage flag_hong_kong() {
    return AssetImage(asset.flag_hong_kong.keyName);
  }

  /// asset: assets/images/flag_hungary.png
  AssetImage flag_hungary() {
    return AssetImage(asset.flag_hungary.keyName);
  }

  /// asset: assets/images/flag_iceland.png
  AssetImage flag_iceland() {
    return AssetImage(asset.flag_iceland.keyName);
  }

  /// asset: assets/images/flag_india.png
  AssetImage flag_india() {
    return AssetImage(asset.flag_india.keyName);
  }

  /// asset: assets/images/flag_indonesia.png
  AssetImage flag_indonesia() {
    return AssetImage(asset.flag_indonesia.keyName);
  }

  /// asset: assets/images/flag_iran.png
  AssetImage flag_iran() {
    return AssetImage(asset.flag_iran.keyName);
  }

  /// asset: assets/images/flag_iraq.png
  AssetImage flag_iraq() {
    return AssetImage(asset.flag_iraq.keyName);
  }

  /// asset: assets/images/flag_ireland.png
  AssetImage flag_ireland() {
    return AssetImage(asset.flag_ireland.keyName);
  }

  /// asset: assets/images/flag_israel.png
  AssetImage flag_israel() {
    return AssetImage(asset.flag_israel.keyName);
  }

  /// asset: assets/images/flag_italy.png
  AssetImage flag_italy() {
    return AssetImage(asset.flag_italy.keyName);
  }

  /// asset: assets/images/flag_jamaica.png
  AssetImage flag_jamaica() {
    return AssetImage(asset.flag_jamaica.keyName);
  }

  /// asset: assets/images/flag_japan.png
  AssetImage flag_japan() {
    return AssetImage(asset.flag_japan.keyName);
  }

  /// asset: assets/images/flag_jordan.png
  AssetImage flag_jordan() {
    return AssetImage(asset.flag_jordan.keyName);
  }

  /// asset: assets/images/flag_kazakhstan.png
  AssetImage flag_kazakhstan() {
    return AssetImage(asset.flag_kazakhstan.keyName);
  }

  /// asset: assets/images/flag_kosovo.png
  AssetImage flag_kosovo() {
    return AssetImage(asset.flag_kosovo.keyName);
  }

  /// asset: assets/images/flag_kuwait.png
  AssetImage flag_kuwait() {
    return AssetImage(asset.flag_kuwait.keyName);
  }

  /// asset: assets/images/flag_laos.png
  AssetImage flag_laos() {
    return AssetImage(asset.flag_laos.keyName);
  }

  /// asset: assets/images/flag_latvia.png
  AssetImage flag_latvia() {
    return AssetImage(asset.flag_latvia.keyName);
  }

  /// asset: assets/images/flag_lebanon.png
  AssetImage flag_lebanon() {
    return AssetImage(asset.flag_lebanon.keyName);
  }

  /// asset: assets/images/flag_liechtenstein.png
  AssetImage flag_liechtenstein() {
    return AssetImage(asset.flag_liechtenstein.keyName);
  }

  /// asset: assets/images/flag_lithuania.png
  AssetImage flag_lithuania() {
    return AssetImage(asset.flag_lithuania.keyName);
  }

  /// asset: assets/images/flag_luxembourg.png
  AssetImage flag_luxembourg() {
    return AssetImage(asset.flag_luxembourg.keyName);
  }

  /// asset: assets/images/flag_macao.png
  AssetImage flag_macao() {
    return AssetImage(asset.flag_macao.keyName);
  }

  /// asset: assets/images/flag_macedonia.png
  AssetImage flag_macedonia() {
    return AssetImage(asset.flag_macedonia.keyName);
  }

  /// asset: assets/images/flag_malaysia.png
  AssetImage flag_malaysia() {
    return AssetImage(asset.flag_malaysia.keyName);
  }

  /// asset: assets/images/flag_maldives.png
  AssetImage flag_maldives() {
    return AssetImage(asset.flag_maldives.keyName);
  }

  /// asset: assets/images/flag_martinique.png
  AssetImage flag_martinique() {
    return AssetImage(asset.flag_martinique.keyName);
  }

  /// asset: assets/images/flag_mexico.png
  AssetImage flag_mexico() {
    return AssetImage(asset.flag_mexico.keyName);
  }

  /// asset: assets/images/flag_monaco.png
  AssetImage flag_monaco() {
    return AssetImage(asset.flag_monaco.keyName);
  }

  /// asset: assets/images/flag_mongolia.png
  AssetImage flag_mongolia() {
    return AssetImage(asset.flag_mongolia.keyName);
  }

  /// asset: assets/images/flag_myanmar.png
  AssetImage flag_myanmar() {
    return AssetImage(asset.flag_myanmar.keyName);
  }

  /// asset: assets/images/flag_nepal.png
  AssetImage flag_nepal() {
    return AssetImage(asset.flag_nepal.keyName);
  }

  /// asset: assets/images/flag_netherlands.png
  AssetImage flag_netherlands() {
    return AssetImage(asset.flag_netherlands.keyName);
  }

  /// asset: assets/images/flag_nicaragua.png
  AssetImage flag_nicaragua() {
    return AssetImage(asset.flag_nicaragua.keyName);
  }

  /// asset: assets/images/flag_north_korea.png
  AssetImage flag_north_korea() {
    return AssetImage(asset.flag_north_korea.keyName);
  }

  /// asset: assets/images/flag_norway.png
  AssetImage flag_norway() {
    return AssetImage(asset.flag_norway.keyName);
  }

  /// asset: assets/images/flag_oman.png
  AssetImage flag_oman() {
    return AssetImage(asset.flag_oman.keyName);
  }

  /// asset: assets/images/flag_pakistan.png
  AssetImage flag_pakistan() {
    return AssetImage(asset.flag_pakistan.keyName);
  }

  /// asset: assets/images/flag_palestine.png
  AssetImage flag_palestine() {
    return AssetImage(asset.flag_palestine.keyName);
  }

  /// asset: assets/images/flag_panama.png
  AssetImage flag_panama() {
    return AssetImage(asset.flag_panama.keyName);
  }

  /// asset: assets/images/flag_paraguay.png
  AssetImage flag_paraguay() {
    return AssetImage(asset.flag_paraguay.keyName);
  }

  /// asset: assets/images/flag_peru.png
  AssetImage flag_peru() {
    return AssetImage(asset.flag_peru.keyName);
  }

  /// asset: assets/images/flag_philippines.png
  AssetImage flag_philippines() {
    return AssetImage(asset.flag_philippines.keyName);
  }

  /// asset: assets/images/flag_poland.png
  AssetImage flag_poland() {
    return AssetImage(asset.flag_poland.keyName);
  }

  /// asset: assets/images/flag_portugal.png
  AssetImage flag_portugal() {
    return AssetImage(asset.flag_portugal.keyName);
  }

  /// asset: assets/images/flag_puerto_rico.png
  AssetImage flag_puerto_rico() {
    return AssetImage(asset.flag_puerto_rico.keyName);
  }

  /// asset: assets/images/flag_romania.png
  AssetImage flag_romania() {
    return AssetImage(asset.flag_romania.keyName);
  }

  /// asset: assets/images/flag_russia.png
  AssetImage flag_russia() {
    return AssetImage(asset.flag_russia.keyName);
  }

  /// asset: assets/images/flag_saint_kitts_and_nevis.png
  AssetImage flag_saint_kitts_and_nevis() {
    return AssetImage(asset.flag_saint_kitts_and_nevis.keyName);
  }

  /// asset: assets/images/flag_salvador.png
  AssetImage flag_salvador() {
    return AssetImage(asset.flag_salvador.keyName);
  }

  /// asset: assets/images/flag_saudi_arabia.png
  AssetImage flag_saudi_arabia() {
    return AssetImage(asset.flag_saudi_arabia.keyName);
  }

  /// asset: assets/images/flag_serbia.png
  AssetImage flag_serbia() {
    return AssetImage(asset.flag_serbia.keyName);
  }

  /// asset: assets/images/flag_singapore.png
  AssetImage flag_singapore() {
    return AssetImage(asset.flag_singapore.keyName);
  }

  /// asset: assets/images/flag_sint_maarten.png
  AssetImage flag_sint_maarten() {
    return AssetImage(asset.flag_sint_maarten.keyName);
  }

  /// asset: assets/images/flag_slovakia.png
  AssetImage flag_slovakia() {
    return AssetImage(asset.flag_slovakia.keyName);
  }

  /// asset: assets/images/flag_south_korea.png
  AssetImage flag_south_korea() {
    return AssetImage(asset.flag_south_korea.keyName);
  }

  /// asset: assets/images/flag_spain.png
  AssetImage flag_spain() {
    return AssetImage(asset.flag_spain.keyName);
  }

  /// asset: assets/images/flag_sri_lanka.png
  AssetImage flag_sri_lanka() {
    return AssetImage(asset.flag_sri_lanka.keyName);
  }

  /// asset: assets/images/flag_st_vincent_and_the_grenadines.png
  AssetImage flag_st_vincent_and_the_grenadines() {
    return AssetImage(asset.flag_st_vincent_and_the_grenadines.keyName);
  }

  /// asset: assets/images/flag_sweden.png
  AssetImage flag_sweden() {
    return AssetImage(asset.flag_sweden.keyName);
  }

  /// asset: assets/images/flag_switzerland.png
  AssetImage flag_switzerland() {
    return AssetImage(asset.flag_switzerland.keyName);
  }

  /// asset: assets/images/flag_syria.png
  AssetImage flag_syria() {
    return AssetImage(asset.flag_syria.keyName);
  }

  /// asset: assets/images/flag_taiwan.png
  AssetImage flag_taiwan() {
    return AssetImage(asset.flag_taiwan.keyName);
  }

  /// asset: assets/images/flag_thailand.png
  AssetImage flag_thailand() {
    return AssetImage(asset.flag_thailand.keyName);
  }

  /// asset: assets/images/flag_trinidad_and_tobago.png
  AssetImage flag_trinidad_and_tobago() {
    return AssetImage(asset.flag_trinidad_and_tobago.keyName);
  }

  /// asset: assets/images/flag_turkey.png
  AssetImage flag_turkey() {
    return AssetImage(asset.flag_turkey.keyName);
  }

  /// asset: assets/images/flag_turkmenistan.png
  AssetImage flag_turkmenistan() {
    return AssetImage(asset.flag_turkmenistan.keyName);
  }

  /// asset: assets/images/flag_ukraine.png
  AssetImage flag_ukraine() {
    return AssetImage(asset.flag_ukraine.keyName);
  }

  /// asset: assets/images/flag_uruguay.png
  AssetImage flag_uruguay() {
    return AssetImage(asset.flag_uruguay.keyName);
  }

  /// asset: assets/images/flag_uzbekistn.png
  AssetImage flag_uzbekistn() {
    return AssetImage(asset.flag_uzbekistn.keyName);
  }

  /// asset: assets/images/flag_venezuela.png
  AssetImage flag_venezuela() {
    return AssetImage(asset.flag_venezuela.keyName);
  }

  /// asset: assets/images/flag_vietnam.png
  AssetImage flag_vietnam() {
    return AssetImage(asset.flag_vietnam.keyName);
  }

  /// asset: assets/images/ico_ailpay.png
  AssetImage ico_ailpay() {
    return AssetImage(asset.ico_ailpay.keyName);
  }

  /// asset: assets/images/ico_ailpay_seleted.png
  AssetImage ico_ailpay_seleted() {
    return AssetImage(asset.ico_ailpay_seleted.keyName);
  }

  /// asset: assets/images/ico_ailpay_seleted_2.png
  AssetImage ico_ailpay_seleted_2() {
    return AssetImage(asset.ico_ailpay_seleted_2.keyName);
  }

  /// asset: assets/images/ico_broadcast.png
  AssetImage ico_broadcast() {
    return AssetImage(asset.ico_broadcast.keyName);
  }

  /// asset: assets/images/ico_close.png
  AssetImage ico_close() {
    return AssetImage(asset.ico_close.keyName);
  }

  /// asset: assets/images/ico_deferment.png
  AssetImage ico_deferment() {
    return AssetImage(asset.ico_deferment.keyName);
  }

  /// asset: assets/images/ico_emoji_1.png
  AssetImage ico_emoji_1() {
    return AssetImage(asset.ico_emoji_1.keyName);
  }

  /// asset: assets/images/ico_emoji_2.png
  AssetImage ico_emoji_2() {
    return AssetImage(asset.ico_emoji_2.keyName);
  }

  /// asset: assets/images/ico_eye.png
  AssetImage ico_eye() {
    return AssetImage(asset.ico_eye.keyName);
  }

  /// asset: assets/images/ico_eye_1.png
  AssetImage ico_eye_1() {
    return AssetImage(asset.ico_eye_1.keyName);
  }

  /// asset: assets/images/ico_eyeslash.png
  AssetImage ico_eyeslash() {
    return AssetImage(asset.ico_eyeslash.keyName);
  }

  /// asset: assets/images/ico_eyeslash_1.png
  AssetImage ico_eyeslash_1() {
    return AssetImage(asset.ico_eyeslash_1.keyName);
  }

  /// asset: assets/images/ico_handshake.png
  AssetImage ico_handshake() {
    return AssetImage(asset.ico_handshake.keyName);
  }

  /// asset: assets/images/ico_handshake_1.png
  AssetImage ico_handshake_1() {
    return AssetImage(asset.ico_handshake_1.keyName);
  }

  /// asset: assets/images/ico_home_n.png
  AssetImage ico_home_n() {
    return AssetImage(asset.ico_home_n.keyName);
  }

  /// asset: assets/images/ico_home_p.png
  AssetImage ico_home_p() {
    return AssetImage(asset.ico_home_p.keyName);
  }

  /// asset: assets/images/ico_invite_friends.png
  AssetImage ico_invite_friends() {
    return AssetImage(asset.ico_invite_friends.keyName);
  }

  /// asset: assets/images/ico_invite_gift.png
  AssetImage ico_invite_gift() {
    return AssetImage(asset.ico_invite_gift.keyName);
  }

  /// asset: assets/images/ico_lock.png
  AssetImage ico_lock() {
    return AssetImage(asset.ico_lock.keyName);
  }

  /// asset: assets/images/ico_lock_1.png
  AssetImage ico_lock_1() {
    return AssetImage(asset.ico_lock_1.keyName);
  }

  /// asset: assets/images/ico_lock_2.png
  AssetImage ico_lock_2() {
    return AssetImage(asset.ico_lock_2.keyName);
  }

  /// asset: assets/images/ico_mail.png
  AssetImage ico_mail() {
    return AssetImage(asset.ico_mail.keyName);
  }

  /// asset: assets/images/ico_mail_1.png
  AssetImage ico_mail_1() {
    return AssetImage(asset.ico_mail_1.keyName);
  }

  /// asset: assets/images/ico_mail_2.png
  AssetImage ico_mail_2() {
    return AssetImage(asset.ico_mail_2.keyName);
  }

  /// asset: assets/images/ico_my_n.png
  AssetImage ico_my_n() {
    return AssetImage(asset.ico_my_n.keyName);
  }

  /// asset: assets/images/ico_my_p.png
  AssetImage ico_my_p() {
    return AssetImage(asset.ico_my_p.keyName);
  }

  /// asset: assets/images/ico_power.png
  AssetImage ico_power() {
    return AssetImage(asset.ico_power.keyName);
  }

  /// asset: assets/images/ico_power_big.png
  AssetImage ico_power_big() {
    return AssetImage(asset.ico_power_big.keyName);
  }

  /// asset: assets/images/ico_shieldcheck.png
  AssetImage ico_shieldcheck() {
    return AssetImage(asset.ico_shieldcheck.keyName);
  }

  /// asset: assets/images/ico_signal_1.png
  AssetImage ico_signal_1() {
    return AssetImage(asset.ico_signal_1.keyName);
  }

  /// asset: assets/images/ico_signal_2.png
  AssetImage ico_signal_2() {
    return AssetImage(asset.ico_signal_2.keyName);
  }

  /// asset: assets/images/ico_signal_3.png
  AssetImage ico_signal_3() {
    return AssetImage(asset.ico_signal_3.keyName);
  }

  /// asset: assets/images/ico_step_gift.png
  AssetImage ico_step_gift() {
    return AssetImage(asset.ico_step_gift.keyName);
  }

  /// asset: assets/images/ico_success.png
  AssetImage ico_success() {
    return AssetImage(asset.ico_success.keyName);
  }

  /// asset: assets/images/ico_vip_n.png
  AssetImage ico_vip_n() {
    return AssetImage(asset.ico_vip_n.keyName);
  }

  /// asset: assets/images/ico_vip_p.png
  AssetImage ico_vip_p() {
    return AssetImage(asset.ico_vip_p.keyName);
  }

  /// asset: assets/images/ico_warning_red.png
  AssetImage ico_warning_red() {
    return AssetImage(asset.ico_warning_red.keyName);
  }

  /// asset: assets/images/ico_warning_white.png
  AssetImage ico_warning_white() {
    return AssetImage(asset.ico_warning_white.keyName);
  }

  /// asset: assets/images/ico_wechatpay.png
  AssetImage ico_wechatpay() {
    return AssetImage(asset.ico_wechatpay.keyName);
  }

  /// asset: assets/images/ico_wechatpay_selected.png
  AssetImage ico_wechatpay_selected() {
    return AssetImage(asset.ico_wechatpay_selected.keyName);
  }

  /// asset: assets/images/icon_about.png
  AssetImage icon_about() {
    return AssetImage(asset.icon_about.keyName);
  }

  /// asset: assets/images/icon_help.png
  AssetImage icon_help() {
    return AssetImage(asset.icon_help.keyName);
  }

  /// asset: assets/images/icon_link.png
  AssetImage icon_link() {
    return AssetImage(asset.icon_link.keyName);
  }

  /// asset: assets/images/icon_linked.png
  AssetImage icon_linked() {
    return AssetImage(asset.icon_linked.keyName);
  }

  /// asset: assets/images/icon_notice.png
  AssetImage icon_notice() {
    return AssetImage(asset.icon_notice.keyName);
  }

  /// asset: assets/images/icon_opinion.png
  AssetImage icon_opinion() {
    return AssetImage(asset.icon_opinion.keyName);
  }

  /// asset: assets/images/img_animation_blue.png
  AssetImage img_animation_blue() {
    return AssetImage(asset.img_animation_blue.keyName);
  }

  /// asset: assets/images/img_animation_circle.png
  AssetImage img_animation_circle() {
    return AssetImage(asset.img_animation_circle.keyName);
  }

  /// asset: assets/images/img_animation_red.png
  AssetImage img_animation_red() {
    return AssetImage(asset.img_animation_red.keyName);
  }

  /// asset: assets/images/img_coupon_use.png
  AssetImage img_coupon_use() {
    return AssetImage(asset.img_coupon_use.keyName);
  }

  /// asset: assets/images/img_coupon_used.png
  AssetImage img_coupon_used() {
    return AssetImage(asset.img_coupon_used.keyName);
  }

  /// asset: assets/images/img_earnpoint.png
  AssetImage img_earnpoint() {
    return AssetImage(asset.img_earnpoint.keyName);
  }

  /// asset: assets/images/img_empty.png
  AssetImage img_empty() {
    return AssetImage(asset.img_empty.keyName);
  }

  /// asset: assets/images/img_fill.png
  AssetImage img_fill() {
    return AssetImage(asset.img_fill.keyName);
  }

  /// asset: assets/images/img_gift.png
  AssetImage img_gift() {
    return AssetImage(asset.img_gift.keyName);
  }

  /// asset: assets/images/img_login_bg.png
  AssetImage img_login_bg() {
    return AssetImage(asset.img_login_bg.keyName);
  }

  /// asset: assets/images/img_rocket.png
  AssetImage img_rocket() {
    return AssetImage(asset.img_rocket.keyName);
  }

  /// asset: assets/images/img_safety.png
  AssetImage img_safety() {
    return AssetImage(asset.img_safety.keyName);
  }

  /// asset: assets/images/img_service.png
  AssetImage img_service() {
    return AssetImage(asset.img_service.keyName);
  }

  /// asset: assets/images/img_special.png
  AssetImage img_special() {
    return AssetImage(asset.img_special.keyName);
  }

  /// asset: assets/images/img_speed.png
  AssetImage img_speed() {
    return AssetImage(asset.img_speed.keyName);
  }

  /// asset: assets/images/img_success.png
  AssetImage img_success() {
    return AssetImage(asset.img_success.keyName);
  }

  /// asset: assets/images/img_vip.png
  AssetImage img_vip() {
    return AssetImage(asset.img_vip.keyName);
  }
}

// ignore: camel_case_types
class _R_Image_AssetResource {
  const _R_Image_AssetResource();

  /// asset: assets/images/btn_back_n.png
  final btn_back_n = const AssetResource("assets/images/btn_back_n.png");

  /// asset: assets/images/btn_back_p.png
  final btn_back_p = const AssetResource("assets/images/btn_back_p.png");

  /// asset: assets/images/btn_back_white_n.png
  final btn_back_white_n =
      const AssetResource("assets/images/btn_back_white_n.png");

  /// asset: assets/images/btn_back_white_p.png
  final btn_back_white_p =
      const AssetResource("assets/images/btn_back_white_p.png");

  /// asset: assets/images/btn_camera_n.png
  final btn_camera_n = const AssetResource("assets/images/btn_camera_n.png");

  /// asset: assets/images/btn_camera_p.png
  final btn_camera_p = const AssetResource("assets/images/btn_camera_p.png");

  /// asset: assets/images/btn_close_n.png
  final btn_close_n = const AssetResource("assets/images/btn_close_n.png");

  /// asset: assets/images/btn_close_p.png
  final btn_close_p = const AssetResource("assets/images/btn_close_p.png");

  /// asset: assets/images/btn_copy_n.png
  final btn_copy_n = const AssetResource("assets/images/btn_copy_n.png");

  /// asset: assets/images/btn_copy_p.png
  final btn_copy_p = const AssetResource("assets/images/btn_copy_p.png");

  /// asset: assets/images/btn_dropdown_n.png
  final btn_dropdown_n =
      const AssetResource("assets/images/btn_dropdown_n.png");

  /// asset: assets/images/btn_dropdown_p.png
  final btn_dropdown_p =
      const AssetResource("assets/images/btn_dropdown_p.png");

  /// asset: assets/images/btn_history_n.png
  final btn_history_n = const AssetResource("assets/images/btn_history_n.png");

  /// asset: assets/images/btn_history_p.png
  final btn_history_p = const AssetResource("assets/images/btn_history_p.png");

  /// asset: assets/images/btn_imgdelete_n.png
  final btn_imgdelete_n =
      const AssetResource("assets/images/btn_imgdelete_n.png");

  /// asset: assets/images/btn_imgdelete_p.png
  final btn_imgdelete_p =
      const AssetResource("assets/images/btn_imgdelete_p.png");

  /// asset: assets/images/btn_next_n.png
  final btn_next_n = const AssetResource("assets/images/btn_next_n.png");

  /// asset: assets/images/btn_next_p.png
  final btn_next_p = const AssetResource("assets/images/btn_next_p.png");

  /// asset: assets/images/btn_next_white_n.png
  final btn_next_white_n =
      const AssetResource("assets/images/btn_next_white_n.png");

  /// asset: assets/images/btn_next_white_p.png
  final btn_next_white_p =
      const AssetResource("assets/images/btn_next_white_p.png");

  /// asset: assets/images/btn_notgood_n.png
  final btn_notgood_n = const AssetResource("assets/images/btn_notgood_n.png");

  /// asset: assets/images/btn_notgood_p.png
  final btn_notgood_p = const AssetResource("assets/images/btn_notgood_p.png");

  /// asset: assets/images/btn_radio_n.png
  final btn_radio_n = const AssetResource("assets/images/btn_radio_n.png");

  /// asset: assets/images/btn_radio_p.png
  final btn_radio_p = const AssetResource("assets/images/btn_radio_p.png");

  /// asset: assets/images/btn_setting_n.png
  final btn_setting_n = const AssetResource("assets/images/btn_setting_n.png");

  /// asset: assets/images/btn_setting_p.png
  final btn_setting_p = const AssetResource("assets/images/btn_setting_p.png");

  /// asset: assets/images/btn_share_n.png
  final btn_share_n = const AssetResource("assets/images/btn_share_n.png");

  /// asset: assets/images/btn_share_p.png
  final btn_share_p = const AssetResource("assets/images/btn_share_p.png");

  /// asset: assets/images/btn_sogood_n.png
  final btn_sogood_n = const AssetResource("assets/images/btn_sogood_n.png");

  /// asset: assets/images/btn_sogood_p.png
  final btn_sogood_p = const AssetResource("assets/images/btn_sogood_p.png");

  /// asset: assets/images/btn_soso_n.png
  final btn_soso_n = const AssetResource("assets/images/btn_soso_n.png");

  /// asset: assets/images/btn_soso_p.png
  final btn_soso_p = const AssetResource("assets/images/btn_soso_p.png");

  /// asset: assets/images/ellipse_11.png
  final ellipse_11 = const AssetResource("assets/images/ellipse_11.png");

  /// asset: assets/images/eye.png
  final eye = const AssetResource("assets/images/eye.png");

  /// asset: assets/images/eye_slash.png
  final eye_slash = const AssetResource("assets/images/eye_slash.png");

  /// asset: assets/images/flag_albania.png
  final flag_albania = const AssetResource("assets/images/flag_albania.png");

  /// asset: assets/images/flag_america.png
  final flag_america = const AssetResource("assets/images/flag_america.png");

  /// asset: assets/images/flag_american_samoa.png
  final flag_american_samoa =
      const AssetResource("assets/images/flag_american_samoa.png");

  /// asset: assets/images/flag_andorra.png
  final flag_andorra = const AssetResource("assets/images/flag_andorra.png");

  /// asset: assets/images/flag_argentina.png
  final flag_argentina =
      const AssetResource("assets/images/flag_argentina.png");

  /// asset: assets/images/flag_aruba.png
  final flag_aruba = const AssetResource("assets/images/flag_aruba.png");

  /// asset: assets/images/flag_austria.png
  final flag_austria = const AssetResource("assets/images/flag_austria.png");

  /// asset: assets/images/flag_auto.png
  final flag_auto = const AssetResource("assets/images/flag_auto.png");

  /// asset: assets/images/flag_bahamas.png
  final flag_bahamas = const AssetResource("assets/images/flag_bahamas.png");

  /// asset: assets/images/flag_belarus.png
  final flag_belarus = const AssetResource("assets/images/flag_belarus.png");

  /// asset: assets/images/flag_belgium.png
  final flag_belgium = const AssetResource("assets/images/flag_belgium.png");

  /// asset: assets/images/flag_bermuda.png
  final flag_bermuda = const AssetResource("assets/images/flag_bermuda.png");

  /// asset: assets/images/flag_bolivia.png
  final flag_bolivia = const AssetResource("assets/images/flag_bolivia.png");

  /// asset: assets/images/flag_brazil.png
  final flag_brazil = const AssetResource("assets/images/flag_brazil.png");

  /// asset: assets/images/flag_bulgaria.png
  final flag_bulgaria = const AssetResource("assets/images/flag_bulgaria.png");

  /// asset: assets/images/flag_cambodia.png
  final flag_cambodia = const AssetResource("assets/images/flag_cambodia.png");

  /// asset: assets/images/flag_canada.png
  final flag_canada = const AssetResource("assets/images/flag_canada.png");

  /// asset: assets/images/flag_cayman_islands.png
  final flag_cayman_islands =
      const AssetResource("assets/images/flag_cayman_islands.png");

  /// asset: assets/images/flag_chile.png
  final flag_chile = const AssetResource("assets/images/flag_chile.png");

  /// asset: assets/images/flag_china.png
  final flag_china = const AssetResource("assets/images/flag_china.png");

  /// asset: assets/images/flag_colombia.png
  final flag_colombia = const AssetResource("assets/images/flag_colombia.png");

  /// asset: assets/images/flag_costa_rica.png
  final flag_costa_rica =
      const AssetResource("assets/images/flag_costa_rica.png");

  /// asset: assets/images/flag_cuba.png
  final flag_cuba = const AssetResource("assets/images/flag_cuba.png");

  /// asset: assets/images/flag_czech_republic.png
  final flag_czech_republic =
      const AssetResource("assets/images/flag_czech_republic.png");

  /// asset: assets/images/flag_denmark.png
  final flag_denmark = const AssetResource("assets/images/flag_denmark.png");

  /// asset: assets/images/flag_dominican_republic.png
  final flag_dominican_republic =
      const AssetResource("assets/images/flag_dominican_republic.png");

  /// asset: assets/images/flag_ecuador.png
  final flag_ecuador = const AssetResource("assets/images/flag_ecuador.png");

  /// asset: assets/images/flag_egypt.png
  final flag_egypt = const AssetResource("assets/images/flag_egypt.png");

  /// asset: assets/images/flag_estonia.png
  final flag_estonia = const AssetResource("assets/images/flag_estonia.png");

  /// asset: assets/images/flag_falkland_islands.png
  final flag_falkland_islands =
      const AssetResource("assets/images/flag_falkland_islands.png");

  /// asset: assets/images/flag_faroe_islands.png
  final flag_faroe_islands =
      const AssetResource("assets/images/flag_faroe_islands.png");

  /// asset: assets/images/flag_finland.png
  final flag_finland = const AssetResource("assets/images/flag_finland.png");

  /// asset: assets/images/flag_france.png
  final flag_france = const AssetResource("assets/images/flag_france.png");

  /// asset: assets/images/flag_germany.png
  final flag_germany = const AssetResource("assets/images/flag_germany.png");

  /// asset: assets/images/flag_gibraltar.png
  final flag_gibraltar =
      const AssetResource("assets/images/flag_gibraltar.png");

  /// asset: assets/images/flag_greece.png
  final flag_greece = const AssetResource("assets/images/flag_greece.png");

  /// asset: assets/images/flag_greenland.png
  final flag_greenland =
      const AssetResource("assets/images/flag_greenland.png");

  /// asset: assets/images/flag_grenada.png
  final flag_grenada = const AssetResource("assets/images/flag_grenada.png");

  /// asset: assets/images/flag_guatemala.png
  final flag_guatemala =
      const AssetResource("assets/images/flag_guatemala.png");

  /// asset: assets/images/flag_guernsey.png
  final flag_guernsey = const AssetResource("assets/images/flag_guernsey.png");

  /// asset: assets/images/flag_guyana.png
  final flag_guyana = const AssetResource("assets/images/flag_guyana.png");

  /// asset: assets/images/flag_haiti.png
  final flag_haiti = const AssetResource("assets/images/flag_haiti.png");

  /// asset: assets/images/flag_hawaii.png
  final flag_hawaii = const AssetResource("assets/images/flag_hawaii.png");

  /// asset: assets/images/flag_honduras.png
  final flag_honduras = const AssetResource("assets/images/flag_honduras.png");

  /// asset: assets/images/flag_hong_kong.png
  final flag_hong_kong =
      const AssetResource("assets/images/flag_hong_kong.png");

  /// asset: assets/images/flag_hungary.png
  final flag_hungary = const AssetResource("assets/images/flag_hungary.png");

  /// asset: assets/images/flag_iceland.png
  final flag_iceland = const AssetResource("assets/images/flag_iceland.png");

  /// asset: assets/images/flag_india.png
  final flag_india = const AssetResource("assets/images/flag_india.png");

  /// asset: assets/images/flag_indonesia.png
  final flag_indonesia =
      const AssetResource("assets/images/flag_indonesia.png");

  /// asset: assets/images/flag_iran.png
  final flag_iran = const AssetResource("assets/images/flag_iran.png");

  /// asset: assets/images/flag_iraq.png
  final flag_iraq = const AssetResource("assets/images/flag_iraq.png");

  /// asset: assets/images/flag_ireland.png
  final flag_ireland = const AssetResource("assets/images/flag_ireland.png");

  /// asset: assets/images/flag_israel.png
  final flag_israel = const AssetResource("assets/images/flag_israel.png");

  /// asset: assets/images/flag_italy.png
  final flag_italy = const AssetResource("assets/images/flag_italy.png");

  /// asset: assets/images/flag_jamaica.png
  final flag_jamaica = const AssetResource("assets/images/flag_jamaica.png");

  /// asset: assets/images/flag_japan.png
  final flag_japan = const AssetResource("assets/images/flag_japan.png");

  /// asset: assets/images/flag_jordan.png
  final flag_jordan = const AssetResource("assets/images/flag_jordan.png");

  /// asset: assets/images/flag_kazakhstan.png
  final flag_kazakhstan =
      const AssetResource("assets/images/flag_kazakhstan.png");

  /// asset: assets/images/flag_kosovo.png
  final flag_kosovo = const AssetResource("assets/images/flag_kosovo.png");

  /// asset: assets/images/flag_kuwait.png
  final flag_kuwait = const AssetResource("assets/images/flag_kuwait.png");

  /// asset: assets/images/flag_laos.png
  final flag_laos = const AssetResource("assets/images/flag_laos.png");

  /// asset: assets/images/flag_latvia.png
  final flag_latvia = const AssetResource("assets/images/flag_latvia.png");

  /// asset: assets/images/flag_lebanon.png
  final flag_lebanon = const AssetResource("assets/images/flag_lebanon.png");

  /// asset: assets/images/flag_liechtenstein.png
  final flag_liechtenstein =
      const AssetResource("assets/images/flag_liechtenstein.png");

  /// asset: assets/images/flag_lithuania.png
  final flag_lithuania =
      const AssetResource("assets/images/flag_lithuania.png");

  /// asset: assets/images/flag_luxembourg.png
  final flag_luxembourg =
      const AssetResource("assets/images/flag_luxembourg.png");

  /// asset: assets/images/flag_macao.png
  final flag_macao = const AssetResource("assets/images/flag_macao.png");

  /// asset: assets/images/flag_macedonia.png
  final flag_macedonia =
      const AssetResource("assets/images/flag_macedonia.png");

  /// asset: assets/images/flag_malaysia.png
  final flag_malaysia = const AssetResource("assets/images/flag_malaysia.png");

  /// asset: assets/images/flag_maldives.png
  final flag_maldives = const AssetResource("assets/images/flag_maldives.png");

  /// asset: assets/images/flag_martinique.png
  final flag_martinique =
      const AssetResource("assets/images/flag_martinique.png");

  /// asset: assets/images/flag_mexico.png
  final flag_mexico = const AssetResource("assets/images/flag_mexico.png");

  /// asset: assets/images/flag_monaco.png
  final flag_monaco = const AssetResource("assets/images/flag_monaco.png");

  /// asset: assets/images/flag_mongolia.png
  final flag_mongolia = const AssetResource("assets/images/flag_mongolia.png");

  /// asset: assets/images/flag_myanmar.png
  final flag_myanmar = const AssetResource("assets/images/flag_myanmar.png");

  /// asset: assets/images/flag_nepal.png
  final flag_nepal = const AssetResource("assets/images/flag_nepal.png");

  /// asset: assets/images/flag_netherlands.png
  final flag_netherlands =
      const AssetResource("assets/images/flag_netherlands.png");

  /// asset: assets/images/flag_nicaragua.png
  final flag_nicaragua =
      const AssetResource("assets/images/flag_nicaragua.png");

  /// asset: assets/images/flag_north_korea.png
  final flag_north_korea =
      const AssetResource("assets/images/flag_north_korea.png");

  /// asset: assets/images/flag_norway.png
  final flag_norway = const AssetResource("assets/images/flag_norway.png");

  /// asset: assets/images/flag_oman.png
  final flag_oman = const AssetResource("assets/images/flag_oman.png");

  /// asset: assets/images/flag_pakistan.png
  final flag_pakistan = const AssetResource("assets/images/flag_pakistan.png");

  /// asset: assets/images/flag_palestine.png
  final flag_palestine =
      const AssetResource("assets/images/flag_palestine.png");

  /// asset: assets/images/flag_panama.png
  final flag_panama = const AssetResource("assets/images/flag_panama.png");

  /// asset: assets/images/flag_paraguay.png
  final flag_paraguay = const AssetResource("assets/images/flag_paraguay.png");

  /// asset: assets/images/flag_peru.png
  final flag_peru = const AssetResource("assets/images/flag_peru.png");

  /// asset: assets/images/flag_philippines.png
  final flag_philippines =
      const AssetResource("assets/images/flag_philippines.png");

  /// asset: assets/images/flag_poland.png
  final flag_poland = const AssetResource("assets/images/flag_poland.png");

  /// asset: assets/images/flag_portugal.png
  final flag_portugal = const AssetResource("assets/images/flag_portugal.png");

  /// asset: assets/images/flag_puerto_rico.png
  final flag_puerto_rico =
      const AssetResource("assets/images/flag_puerto_rico.png");

  /// asset: assets/images/flag_romania.png
  final flag_romania = const AssetResource("assets/images/flag_romania.png");

  /// asset: assets/images/flag_russia.png
  final flag_russia = const AssetResource("assets/images/flag_russia.png");

  /// asset: assets/images/flag_saint_kitts_and_nevis.png
  final flag_saint_kitts_and_nevis =
      const AssetResource("assets/images/flag_saint_kitts_and_nevis.png");

  /// asset: assets/images/flag_salvador.png
  final flag_salvador = const AssetResource("assets/images/flag_salvador.png");

  /// asset: assets/images/flag_saudi_arabia.png
  final flag_saudi_arabia =
      const AssetResource("assets/images/flag_saudi_arabia.png");

  /// asset: assets/images/flag_serbia.png
  final flag_serbia = const AssetResource("assets/images/flag_serbia.png");

  /// asset: assets/images/flag_singapore.png
  final flag_singapore =
      const AssetResource("assets/images/flag_singapore.png");

  /// asset: assets/images/flag_sint_maarten.png
  final flag_sint_maarten =
      const AssetResource("assets/images/flag_sint_maarten.png");

  /// asset: assets/images/flag_slovakia.png
  final flag_slovakia = const AssetResource("assets/images/flag_slovakia.png");

  /// asset: assets/images/flag_south_korea.png
  final flag_south_korea =
      const AssetResource("assets/images/flag_south_korea.png");

  /// asset: assets/images/flag_spain.png
  final flag_spain = const AssetResource("assets/images/flag_spain.png");

  /// asset: assets/images/flag_sri_lanka.png
  final flag_sri_lanka =
      const AssetResource("assets/images/flag_sri_lanka.png");

  /// asset: assets/images/flag_st_vincent_and_the_grenadines.png
  final flag_st_vincent_and_the_grenadines = const AssetResource(
      "assets/images/flag_st_vincent_and_the_grenadines.png");

  /// asset: assets/images/flag_sweden.png
  final flag_sweden = const AssetResource("assets/images/flag_sweden.png");

  /// asset: assets/images/flag_switzerland.png
  final flag_switzerland =
      const AssetResource("assets/images/flag_switzerland.png");

  /// asset: assets/images/flag_syria.png
  final flag_syria = const AssetResource("assets/images/flag_syria.png");

  /// asset: assets/images/flag_taiwan.png
  final flag_taiwan = const AssetResource("assets/images/flag_taiwan.png");

  /// asset: assets/images/flag_thailand.png
  final flag_thailand = const AssetResource("assets/images/flag_thailand.png");

  /// asset: assets/images/flag_trinidad_and_tobago.png
  final flag_trinidad_and_tobago =
      const AssetResource("assets/images/flag_trinidad_and_tobago.png");

  /// asset: assets/images/flag_turkey.png
  final flag_turkey = const AssetResource("assets/images/flag_turkey.png");

  /// asset: assets/images/flag_turkmenistan.png
  final flag_turkmenistan =
      const AssetResource("assets/images/flag_turkmenistan.png");

  /// asset: assets/images/flag_ukraine.png
  final flag_ukraine = const AssetResource("assets/images/flag_ukraine.png");

  /// asset: assets/images/flag_uruguay.png
  final flag_uruguay = const AssetResource("assets/images/flag_uruguay.png");

  /// asset: assets/images/flag_uzbekistn.png
  final flag_uzbekistn =
      const AssetResource("assets/images/flag_uzbekistn.png");

  /// asset: assets/images/flag_venezuela.png
  final flag_venezuela =
      const AssetResource("assets/images/flag_venezuela.png");

  /// asset: assets/images/flag_vietnam.png
  final flag_vietnam = const AssetResource("assets/images/flag_vietnam.png");

  /// asset: assets/images/ico_ailpay.png
  final ico_ailpay = const AssetResource("assets/images/ico_ailpay.png");

  /// asset: assets/images/ico_ailpay_seleted.png
  final ico_ailpay_seleted =
      const AssetResource("assets/images/ico_ailpay_seleted.png");

  /// asset: assets/images/ico_ailpay_seleted_2.png
  final ico_ailpay_seleted_2 =
      const AssetResource("assets/images/ico_ailpay_seleted_2.png");

  /// asset: assets/images/ico_broadcast.png
  final ico_broadcast = const AssetResource("assets/images/ico_broadcast.png");

  /// asset: assets/images/ico_close.png
  final ico_close = const AssetResource("assets/images/ico_close.png");

  /// asset: assets/images/ico_deferment.png
  final ico_deferment = const AssetResource("assets/images/ico_deferment.png");

  /// asset: assets/images/ico_emoji_1.png
  final ico_emoji_1 = const AssetResource("assets/images/ico_emoji_1.png");

  /// asset: assets/images/ico_emoji_2.png
  final ico_emoji_2 = const AssetResource("assets/images/ico_emoji_2.png");

  /// asset: assets/images/ico_eye.png
  final ico_eye = const AssetResource("assets/images/ico_eye.png");

  /// asset: assets/images/ico_eye_1.png
  final ico_eye_1 = const AssetResource("assets/images/ico_eye_1.png");

  /// asset: assets/images/ico_eyeslash.png
  final ico_eyeslash = const AssetResource("assets/images/ico_eyeslash.png");

  /// asset: assets/images/ico_eyeslash_1.png
  final ico_eyeslash_1 =
      const AssetResource("assets/images/ico_eyeslash_1.png");

  /// asset: assets/images/ico_handshake.png
  final ico_handshake = const AssetResource("assets/images/ico_handshake.png");

  /// asset: assets/images/ico_handshake_1.png
  final ico_handshake_1 =
      const AssetResource("assets/images/ico_handshake_1.png");

  /// asset: assets/images/ico_home_n.png
  final ico_home_n = const AssetResource("assets/images/ico_home_n.png");

  /// asset: assets/images/ico_home_p.png
  final ico_home_p = const AssetResource("assets/images/ico_home_p.png");

  /// asset: assets/images/ico_invite_friends.png
  final ico_invite_friends =
      const AssetResource("assets/images/ico_invite_friends.png");

  /// asset: assets/images/ico_invite_gift.png
  final ico_invite_gift =
      const AssetResource("assets/images/ico_invite_gift.png");

  /// asset: assets/images/ico_lock.png
  final ico_lock = const AssetResource("assets/images/ico_lock.png");

  /// asset: assets/images/ico_lock_1.png
  final ico_lock_1 = const AssetResource("assets/images/ico_lock_1.png");

  /// asset: assets/images/ico_lock_2.png
  final ico_lock_2 = const AssetResource("assets/images/ico_lock_2.png");

  /// asset: assets/images/ico_mail.png
  final ico_mail = const AssetResource("assets/images/ico_mail.png");

  /// asset: assets/images/ico_mail_1.png
  final ico_mail_1 = const AssetResource("assets/images/ico_mail_1.png");

  /// asset: assets/images/ico_mail_2.png
  final ico_mail_2 = const AssetResource("assets/images/ico_mail_2.png");

  /// asset: assets/images/ico_my_n.png
  final ico_my_n = const AssetResource("assets/images/ico_my_n.png");

  /// asset: assets/images/ico_my_p.png
  final ico_my_p = const AssetResource("assets/images/ico_my_p.png");

  /// asset: assets/images/ico_power.png
  final ico_power = const AssetResource("assets/images/ico_power.png");

  /// asset: assets/images/ico_power_big.png
  final ico_power_big = const AssetResource("assets/images/ico_power_big.png");

  /// asset: assets/images/ico_shieldcheck.png
  final ico_shieldcheck =
      const AssetResource("assets/images/ico_shieldcheck.png");

  /// asset: assets/images/ico_signal_1.png
  final ico_signal_1 = const AssetResource("assets/images/ico_signal_1.png");

  /// asset: assets/images/ico_signal_2.png
  final ico_signal_2 = const AssetResource("assets/images/ico_signal_2.png");

  /// asset: assets/images/ico_signal_3.png
  final ico_signal_3 = const AssetResource("assets/images/ico_signal_3.png");

  /// asset: assets/images/ico_step_gift.png
  final ico_step_gift = const AssetResource("assets/images/ico_step_gift.png");

  /// asset: assets/images/ico_success.png
  final ico_success = const AssetResource("assets/images/ico_success.png");

  /// asset: assets/images/ico_vip_n.png
  final ico_vip_n = const AssetResource("assets/images/ico_vip_n.png");

  /// asset: assets/images/ico_vip_p.png
  final ico_vip_p = const AssetResource("assets/images/ico_vip_p.png");

  /// asset: assets/images/ico_warning_red.png
  final ico_warning_red =
      const AssetResource("assets/images/ico_warning_red.png");

  /// asset: assets/images/ico_warning_white.png
  final ico_warning_white =
      const AssetResource("assets/images/ico_warning_white.png");

  /// asset: assets/images/ico_wechatpay.png
  final ico_wechatpay = const AssetResource("assets/images/ico_wechatpay.png");

  /// asset: assets/images/ico_wechatpay_selected.png
  final ico_wechatpay_selected =
      const AssetResource("assets/images/ico_wechatpay_selected.png");

  /// asset: assets/images/icon_about.png
  final icon_about = const AssetResource("assets/images/icon_about.png");

  /// asset: assets/images/icon_help.png
  final icon_help = const AssetResource("assets/images/icon_help.png");

  /// asset: assets/images/icon_link.png
  final icon_link = const AssetResource("assets/images/icon_link.png");

  /// asset: assets/images/icon_linked.png
  final icon_linked = const AssetResource("assets/images/icon_linked.png");

  /// asset: assets/images/icon_notice.png
  final icon_notice = const AssetResource("assets/images/icon_notice.png");

  /// asset: assets/images/icon_opinion.png
  final icon_opinion = const AssetResource("assets/images/icon_opinion.png");

  /// asset: assets/images/img_animation_blue.png
  final img_animation_blue =
      const AssetResource("assets/images/img_animation_blue.png");

  /// asset: assets/images/img_animation_circle.png
  final img_animation_circle =
      const AssetResource("assets/images/img_animation_circle.png");

  /// asset: assets/images/img_animation_red.png
  final img_animation_red =
      const AssetResource("assets/images/img_animation_red.png");

  /// asset: assets/images/img_coupon_use.png
  final img_coupon_use =
      const AssetResource("assets/images/img_coupon_use.png");

  /// asset: assets/images/img_coupon_used.png
  final img_coupon_used =
      const AssetResource("assets/images/img_coupon_used.png");

  /// asset: assets/images/img_earnpoint.png
  final img_earnpoint = const AssetResource("assets/images/img_earnpoint.png");

  /// asset: assets/images/img_empty.png
  final img_empty = const AssetResource("assets/images/img_empty.png");

  /// asset: assets/images/img_fill.png
  final img_fill = const AssetResource("assets/images/img_fill.png");

  /// asset: assets/images/img_gift.png
  final img_gift = const AssetResource("assets/images/img_gift.png");

  /// asset: assets/images/img_login_bg.png
  final img_login_bg = const AssetResource("assets/images/img_login_bg.png");

  /// asset: assets/images/img_rocket.png
  final img_rocket = const AssetResource("assets/images/img_rocket.png");

  /// asset: assets/images/img_safety.png
  final img_safety = const AssetResource("assets/images/img_safety.png");

  /// asset: assets/images/img_service.png
  final img_service = const AssetResource("assets/images/img_service.png");

  /// asset: assets/images/img_special.png
  final img_special = const AssetResource("assets/images/img_special.png");

  /// asset: assets/images/img_speed.png
  final img_speed = const AssetResource("assets/images/img_speed.png");

  /// asset: assets/images/img_success.png
  final img_success = const AssetResource("assets/images/img_success.png");

  /// asset: assets/images/img_vip.png
  final img_vip = const AssetResource("assets/images/img_vip.png");
}

class AssetResource {
  const AssetResource(this.assetName);

  final String assetName;

  String get keyName => "$assetName";
}
