var keywordParser = {
  html: "",
  text: "",
  keywords: "",
  keywordNumber: 20,
  topKeywordsObject: {},
  topKeywordsList: [],
  allKeywords: [],
  blackListKeywords: ["the","be","to","of","and","a","in","that","have","I","it","for","not","on","with","he","as","you","do","at","this","but","his","by","from","they","we","say","her","she","or","an","will","my","one","all","would","there","their","what","so","up","out","if","about","who","get","which","go","me","when","make","can","like","time","no","just","him","know","take","people","into","year","your","good","some","could","them","see","other","than","then","now","look","only","come","its","over","think","also","back","after","use","two","how","our","work","first","well","way","even","new","want","because","any","these","give","day","most","us", "theyre", "youre", ],

  setTopKeywordsList: function() {
    // ignore everything except letters
    this.text = this.html.replace(/[^a-zA-Z ]/g, "");
    this.allKeywords = this.text.match(/\S+/g);
    this.topKeywordsList = [];
    this.topKeywordsObject = {};
    for(keywordIndex in this.allKeywords) {
      var keyword = this.allKeywords[keywordIndex];
      if ((keyword.length <= 2) || (this.blackListKeywords.indexOf(keyword.toLowerCase()) != -1)) { continue; }
      if (keyword in this.topKeywordsObject) {
        this.topKeywordsObject[keyword] += 1
      } else {
        this.topKeywordsObject[keyword] = 1
      }
    }
  },

  orderKeywords: function() {
    for (var keyword in this.topKeywordsObject) {
      this.topKeywordsList.push([keyword, this.topKeywordsObject[keyword]])
    }
    this.topKeywordsList = this.topKeywordsList.sort(function(a, b) {return b[1] - a[1]})
  },

  getTopKeywordsList: function() {
    this.orderKeywords();
    this.keywords = "";
    for(var index = 0; index < this.topKeywordsList.length; index ++) {
      if (index > this.keywordNumber) { break; }
      keyword = this.topKeywordsList[index]
      this.keywords += "</br>kw: " + keyword[0] + " - nr: " + keyword[1];
    }
  },

  showTopKeywords: function() {
    this.setTopKeywordsList();
    this.getTopKeywordsList();
    if ($("#simple-blog-form-keywords-view").length == 0) {
      $("#simple-blog-form-keywords").after("<div id='simple-blog-form-keywords-view'>" + this.keywords +  "</div>");
    } else {
      $("#simple-blog-form-keywords-view").html(this.keywords);
    }
  }
}

CKEDITOR.on("instanceReady", function(evt) {
  CKEDITOR.instances["simple-blog-post-form-body"].document.on("keyup", function(event) {
    var ckeditor = CKEDITOR.instances["simple-blog-post-form-body"]
    keywordParser.html = ckeditor.getData();
    keywordParser.showTopKeywords();
  });
});
