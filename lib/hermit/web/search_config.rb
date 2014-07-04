class SearchConfig

  @@engines =
  {
    "google" =>
    {
      "elements_of_interest" =>
      {
        "search_field" =>
        {
          "how"  => "name",
          "what" => "q"
        },

        "next_page" =>
        {
          "how"   => "id",
          "what"  => "pnnext"
        },

        "predictions" =>
        {
          "how"   => "class",
          "what"  => "gsq_a"
        },

        "alt_predictions" =>
        {
          "how"   => "class",
          "what"  => "gspr_a"
        }
      }
    },

    "bing" =>
    {
      "elements_of_interest" =>
      {
        "search_field" =>
        {
          "how"  => "name",
          "what" => "q"
        },

        "next_page" =>
        {
          "how"   => "class",
          "what"  => "sb_pagN"
        },

        "predictions" =>
        {
          "how"   => "id",
          "what"  => "sa_ul"
        },

        "alt_predictions" =>
        {
          "how"   => "id",
          "what"  => "sa_ul"
        }
      }
    }
  }

  @@blacklisted =
  {
    "tags" =>
    [
      "script",
      "style"
    ],

    "tag_attributes" =>
    [
      "aria-",
      "bgcolor",
      "data-",
      "eid",
      "style",
      "script",
      "src",
      "onload",
      "onclick",
      "onmousedown",
      "jsaction"
    ]
  }

  def self.engines
    @@engines
  end

  def self.blacklisted
    @@blacklisted
  end

end