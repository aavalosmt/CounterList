# Cornershop iOS Development Test

## Before you begin
* You will need to fork this project and invite the following users as collaborators: @matmartinez, @franciscofuentes and @coyarzun89

## The test
Create a simple iOS app for counting things. You'll need to meet high expectations for quality and functionality. It must meet at least the following:

* Add a named counter to a list of counters.
* Increment any of the counters.
* Decrement any of the counters.
* Delete a counter.
* Show a sum of all the counter values.
* Persist data back to the server.
* Must **not** feel like a learning exercise. Think you're building this for the App Store.

Some other notes:

* Showing off the capabilities of UIKit and Core frameworks is **essential**.
* Unreliable networks are a thing. Handle errors.
* This isn't a backend test, don't make it require any databases.
* You can use Swift 4 and the latest beta of Xcode.

Extra points:

* Don't use any external dependencies.
* Lightweight view controllers.
* Showing off some Core Animation knowledge.
* XCTests are good.


A possible app design could be:

```
+-----------------------------+
| [Edit]    Kontwapp      [+] |
+-----------------------------+
+-----------------------------+
| Cups of tea         5 [-|+] |
| Boats I've been on  1 [-|+] |
| White shirts       15 [-|+] |
+-----------------------------+
+-----------------------------+
| [↑]               Total: 21 |
+-----------------------------+
```

**Remember**: The UI is super important. When in doubt, steal from the system apps. Don't build anything that doesn't feel right for iOS.


## Install and start the server

```
$ npm install
$ npm start
```

## API endpoints / examples

The following endpoints are expecting a `Content-Type: application/json`

```
GET /api/v1/counters
[
]

POST { title: "Coffee" } /api/v1/counter
[
	{ id: "adsf", title: "Coffee", count: 0 }
]

POST { title: "Tea" } /api/v1/counter
[
	{ id: "asdf", title: "Coffee", count: 0 },
	{ id: "qwer", title: "Tea", count: 0 }
]

POST { id: "asdf" } /api/v1/counter/inc
[
	{ id: "asdf", title: "Coffee", count: 1 },
	{ id: "qwer", title: "Tea", count: 0 }
]

POST { id: "qwer"} /api/v1/counter/dec
[
	{ id: "asdf", title: "Coffee", count: 1 },
	{ id: "qwer", title: "Tea", count: -1 }
]

DELETE { id: "qwer" } /api/v1/counter
[
	{ id: "asdf", title: "Coffee", count: 1 }
]

GET /api/v1/counters
[
	{ id: "asdf", title: "Coffee", count: 1 },
]
```

*NOTE:* Each request returns the current state of all counters.

---

![](https://i.amz.mshcdn.com/Tb80DWohxhx8kZcFfkop__Jlxck=/fit-in/1200x9600/https%3A%2F%2Fblueprint-api-production.s3.amazonaws.com%2Fuploads%2Fcard%2Fimage%2F812164%2Fda629eac-23be-4894-b625-3e9919bc60b3.png)

_"Design it to look like my shit." -J_
