= Springnote Resources

* 홈페이지: http://myruby.net/pages/391111
* 제작자: deepblue (http://myruby.net), Changshin Lee (http://www.iasandcb.pe.kr)

== 설명:

스프링노트는 REST API를 제공하며, 레일스 프로젝트의 일부인 REST 클라이언트 '액티브리소스(ActiveResource)'를 통해 
매우 쉽게 접근할 수 있다. 이를 활용하면, 자신의 데이터베이스에서 ORM인 액티브레코드를 이용해 데이터를 읽고 쓰는 것처럼, 액티브리소스를 
이용해 스프링노트에 있는 데이터를 쉽게 다룰 수 있다.

== 요구사항:

* activesupport
* activeresource
* oauth
* ruby-hmac

== 설치:

* sudo gem install springnote_resources

== 개발자키와 사용자키 발급 및 설정:

1. 스프링노트 매시업을 작성하기 위해서는 먼저 개발자키가 필요하다. 이 키는 오픈마루 API 센터에서 발급받을 수 있다. 
자세한 내용은 http://dev.springnote.com/pages/372760 에서 얻을 수 있다.

2. 그리고 해당 개발자키에 대한 스프링노트 사용자키를 발급받아야 한다. 이 키 또한 API 센터에서 얻을 수 있다.
자세한 내용은 http://dev.springnote.com/pages/372761에서 얻을 수 있다.

3. 이렇게 받은 키를 스프링노트 리소스에서 사용하려면 아래처럼 설정한다.

Springnote::Base.configuration.set :app_key => '__개발자키__',
  :user_openid => 'http://user-open-id-url/',
  :user_key => '__사용자키__'

== 사용법:

# 페이지 불러오기
page = Springnote::Page.find(144)
puts page.source

# 페이지 수정하기
page = Springnote::Page.find(144)
page.source = '<p>New Contents</p>'
page.save

# 페이지 만들기
page = Springnote::Page.create :title => 'NewName', :source => 'NewContents'

# 페이지 지우기
Springnote::Page.find(144).destroy

== LICENSE:

(The MIT License)

Copyright (c) 2007 Bryan Kang and Changshin Lee

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
