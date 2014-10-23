var KeywordParser = (function () {

  var keywordsObject = {};
  var blackListKeywords = ["the","be","to","of","and","a","in","that","have","I","it","for","not","on","with","he","as","you","do","at","this","but","his","by","from","they","we","say","her","she","or","an","will","my","one","all","would","there","their","what","so","up","out","if","about","who","get","which","go","me","when","make","can","like","time","no","just","him","know","take","people","into","year","your","good","some","could","them","see","other","than","then","now","look","only","come","its","over","think","also","back","after","use","two","how","our","work","first","well","way","even","new","want","because","any","these","give","day","most","us", "theyre", "youre"];

  var setTopKeywordsList = function(html) {
    keywordsObject = {};
    var allKeywords = getAllKeywords(html);
    for (var keywordIndex = 0; keywordIndex < allKeywords.length; keywordIndex++) {
      var keyword = allKeywords[keywordIndex];
      if (keyword in keywordsObject) {
        keywordsObject[keyword] += 1
      } else {
        keywordsObject[keyword] = 1
      }
    }
  };

  var keywordIsNotBlacklisted = function(keyword) {
    // test if keyword length greater then 2 to prevent logging small words
    // test if keyword in blacklist
    return !(keyword.length <= 2) || (blackListKeywords.indexOf(keyword.toLowerCase()) != -1)
  };

  var cleanupKeywords = function(keywordsList) {
    var cleanedUpKeywordsList = [];
    for (var keywordIndex = 0; keywordIndex < keywordsList.length; keywordIndex++) {
      // lowercase keyword so we don't count same word twice
      var keyword = keywordsList[keywordIndex].toLowerCase();
      if (keywordIsNotBlacklisted(keyword)) {
        cleanedUpKeywordsList.push(keyword);
      }
    }
    return cleanedUpKeywordsList;
  }

  var getAllKeywords = function(html) {
    // strip html tags
    // ignore everything except letters
    var keywordsList = html.replace(/[^a-zA-Z0-9 \n]/g, "").match(/[^\s]+/g);
    if (keywordsList == null) {
      // returns an empty list so that nothing blow's up
      return [];
    } else {
      return cleanupKeywords(keywordsList);
    }
  };

  var sortKeywords = function() {
    var keywordsList = [];
    for (var keyword in keywordsObject) {
      keywordsList.push([keyword, keywordsObject[keyword]])
    }
    return keywordsList.sort(function(a, b) {return b[1] - a[1]});
  };

  var getTopKeywordsList = function() {
    var totalAllowedKeywords = 20;
    var keywordsList = sortKeywords();
    var topKeywordsList = [];

    for(var index = 0; index < totalAllowedKeywords; index ++) {
      if (index < keywordsList.length){
        topKeywordsList.push(keywordsList[index]);
      }
    }
    return topKeywordsList;
  };

  var formatOutput = function(topKeywordsList) {
    var keywords = "";
    for (var index = 0; index < topKeywordsList.length; index++) {
      keywords += "</br>kw: " + topKeywordsList[index][0] + " - nr: " + topKeywordsList[index][1];
    }
    return keywords;
  };

  var showTopKeywords = function(html) {
    setTopKeywordsList(html);
    var keywords = formatOutput(getTopKeywordsList())
    if ($("#simple-blog-form-keywords-view").length == 0) {
      $("#simple-blog-post-form").after("<div id='simple-blog-form-keywords-view'>" + keywords +  "</div>");
    } else {
      $("#simple-blog-form-keywords-view").html(keywords);
    }
  };

  return {
    showTopKeywords: showTopKeywords
  };
})();
