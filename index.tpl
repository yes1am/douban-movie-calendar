<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title> <%= title %> </title>
  <style>
    * {
      padding: 0;
      margin: 0;
    }
    ul li {
      list-style: none;
    }
    a {
      text-decoration: none;
    }
    .container {
      max-width: 640px;
      margin: 0 auto;
      padding: 12px 8px;
    }
    .head-content {
      background: #f5f5f5;
      padding: 8px;
      color: #494949;
      font-size: 26px;
    }
    .movie-item {
      background: #f5f5f5;
      margin: 20px 0;
      padding: 8px;
    }
    .movie-item:nth-child(1) {
      margin-top: 0;
    }
    .item-right {
      background: white;
      padding: 8px;
      box-shadow: 0 1px 1px rgba(0,0,0,0.2);
    }
    .title {
      margin-bottom: 4px;
    }
    .rate {
      text-align: right;
      color: #e09015;
      font-size: 12px;
    }
    .item-index {
      position: relative;
      top: -10px;
      display: inline-block;
      padding: 0 10px;
      background: #e3e3e3;
      color: #a1a1a1;
      line-height: 18px;
      border-radius: 0 0 4px 4px;
    }
    .comment {
      color: #404040;
      padding: 12px 8px 4px;
      font-size: 13px;
      white-space: pre-wrap;
    }
    .title a:link,
    .title a:visited,
    .title a:hover,
    .title a:active {
      color: #259;
    }
    .menu-items {
      display: flex;
      overflow-x: auto;
    }
    .menu-item {
      font-size: 13px;
      background: #f5f5f5;
      padding: 2px 11px 0;
      margin-right: 3px;
      word-break: keep-all;
      white-space: nowrap;
      border-radius: 2px 2px 0 0;
    }
    .menu-item.active {
      border-bottom: 2px solid #37A;
      background: #e8e8e8;
    }
    .menu-item a:link,
    .menu-item a:visited,
    .menu-item a:hover,
    .menu-item a:active {
      color: #37A;
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="menu-items">
      <% years.forEach(function(yearItem) { %>
        <% const className = year === yearItem.name ? 'menu-item active' : 'menu-item'; %>
        <div class="<%= className %>">
          <a href="./<%= yearItem.href %>.html"><%= yearItem.name %></a>
        </div>
      <% }); %>
    </div>
    <div class="head-content">
      <%= title %>
    </div>
    <div class="body-content">
      <ul>
        <% movies.forEach(function(movie, index){ %>
          <li class="movie-item">
            <!-- <div class="item-left">
              <img referrerPolicy="no-referrer" src="<%= movie.image %>" alt="">
            </div> -->
            <div class="item-index">
              <%= index + 1 %>
            </div>
            <div class="item-top">
              <div class="item-right">
                <div class="title">
                  <a target="_blank" href="<%= movie.link %>"><%= movie.title %></a>
                </div>
                <div class="rate">
                  豆瓣评分: <%= movie.rating %> / 10
                </div>
              </div>
            </div>
            <div class="item-bottom">
              <div class="comment"><%= movie.comment %></div>
            </div>
          </li>
        <% }); %>
      </ul>
    </div>
  </div>
</body>
</html>