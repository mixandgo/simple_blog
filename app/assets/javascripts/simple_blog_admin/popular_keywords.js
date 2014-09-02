var KeywordParser = (function () {

  var keywords = "";
  var keywordListLength = 20;
  var topKeywordsObject = {};
  var topKeywordsList = [];
  var allKeywords = [];
  var blackListKeywords = ["the","be","to","of","and","a","in","that","have","I","it","for","not","on","with","he","as","you","do","at","this","but","his","by","from","they","we","say","her","she","or","an","will","my","one","all","would","there","their","what","so","up","out","if","about","who","get","which","go","me","when","make","can","like","time","no","just","him","know","take","people","into","year","your","good","some","could","them","see","other","than","then","now","look","only","come","its","over","think","also","back","after","use","two","how","our","work","first","well","way","even","new","want","because","any","these","give","day","most","us", "theyre", "youre"];

  var setTopKeywordsList = function(html) {
    // strip html tags
    // ignore everything except letters
    text = html.replace(/<\/?[^>]+(>|$)/g, "").replace(/[^a-zA-Z ]/g, "");
    allKeywords = text.match(/\S+/g);
    topKeywordsList = [];
    topKeywordsObject = {};
    for(var keywordIndex in allKeywords) {
      var keyword = allKeywords[keywordIndex];
      if ((keyword.length <= 2) || (blackListKeywords.indexOf(keyword.toLowerCase()) != -1)) { continue; }
      if (keyword in topKeywordsObject) {
        topKeywordsObject[keyword] += 1
      } else {
        topKeywordsObject[keyword] = 1
      }
    }
  };

  var orderKeywords = function() {
    for (var keyword in topKeywordsObject) {
      topKeywordsList.push([keyword, topKeywordsObject[keyword]])
    }
    topKeywordsList = topKeywordsList.sort(function(a, b) {return b[1] - a[1]})
  };

  var getTopKeywordsList = function() {
    orderKeywords();
    keywords = "";
    for(var index = 0; index < topKeywordsList.length; index ++) {
      if (index > keywordListLength) { break; }
      keyword = topKeywordsList[index]
      keywords += "</br>kw: " + keyword[0] + " - nr: " + keyword[1];
    }
  };

  var showTopKeywords = function(html) {
    setTopKeywordsList(html);
    getTopKeywordsList();
    if ($("#simple-blog-form-keywords-view").length == 0) {
      $("#simple-blog-form-keywords").after("<div id='simple-blog-form-keywords-view'>" + keywords +  "</div>");
    } else {
      $("#simple-blog-form-keywords-view").html(keywords);
    }
  };

  return {
    showTopKeywords: showTopKeywords
  };
})();
