module BlogLanguages

  LANGUAGES = {"af" => "Afrikaans", "ar" => "Arabic", "az" => "Azerbaijani", "bg" => "Bulgarian", "bn" => "Bengali", "bs" => "Bosnian", "ca" => "Catalan", "cs" => "Czech", "cy" => "Welsh", "da" => "Danish", "de" => "German", "de-AT" => "German-Austria", "de-CH" => "German-Switzerland", "el" => "Greek", "en" => "English", "en-AU" => "English-Australia", "en-CA" => "English-Canada", "en-GB" => "English-United Kingdom", "en-IE" => "English-Ireland", "en-NZ" => "English-New Zealand", "en-US" => "English-United States", "en-ZA" => "English-South Africa", "eo" => "Esperanto", "es" => "Spanish", "es-419" => "Spanish-Latin America", "es-AR" => "Spanish-Argentina", "es-CL" => "Spanish-Chile", "es-CO" => "Spanish-Colombia", "es-CR" => "Spanish-Costa Rica", "es-EC" => "Spanish-Ecuador", "es-MX" => "Spanish-Mexico", "es-PA" => "Spanish-Panama", "es-PE" => "Spanish-Peru", "es-US" => "Spanish-United States", "es-VE" => "Spanish-Venezuela", "et" => "Estonia", "eu" => "", "fa" => "Persian", "fi" => "Finnish", "fr" => "French", "fr-CA" => "French-Canada", "fr-CH" => "French-Switzerland", "gl" => "Galician", "he" => "Hebrew", "hi" => "Hindi", "hi-IN" => "Hindi-India", "hr" => "Croatian", "hu" => "Hungarian", "id" => "Indonesian", "is" => "Icelandic", "it" => "Italian", "it-CH" => "Italian-Switzerland", "ja" => "Japanese", "km" => "Khmer", "kn" => "Kannada", "ko" => "Korean", "lo" => "Lao", "lt" => "Lithuanian", "lv" => "Latvian", "mk" => "Macedonian", "mn" => "Mongolian", "ms" => "Nalay", "nb" => "Norwegian Bokmal", "ne" => "Nepali", "nl" => "Dutch", "nn" => "Norwegian Nynorsk", "or" => "Oriya", "pl" => "Polish", "pt" => "Portuguese", "pt-BR" => "Portuguese-Brazil", "rm" => "Romansh", "ru" => "Russian", "ro" => "Romanian", "sk" => "Saraiki", "sl" => "Slovene", "sr" => "Serbian", "sv" => "Swedish", "sw" => "Swahili", "ta" => "Tamil", "th" => "Thai", "tl" => "Tagalog", "tr" => "Turkish", "uk" => "Ukrainian", "ur" => "Urdu", "uz" => "Uzbek", "vi" => "Vietnamese", "wo" => "Wolof", "zh-CN" => "Chinese-China", "zh-HK" => "Chinese-Hong Kong", "zh-TW" => "Chinese-Taiwan", "zh-YUE" => "Cantonese"}

  def languages_for_select
    LANGUAGES.collect { |country_code, country_translation| [country_translation, country_code]  }
  end

  def language_full_name(language_code)
    LANGUAGES[language_code]
  end

end
