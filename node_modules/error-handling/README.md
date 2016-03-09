error-handling
==============

At VirtuOz we love [Futures](https://github.com/coolaj86/futures).  But when you use it, you end up with lots,
and I do mean *lots*, of boilderplate error-handling code.  Like this:

    var Future = require('futures').future;
    .
    .
    .
    function doSomethingInTheFuture()
    {
        var future = new Future()

        someAsynchronousOperation(function(err, result)
        {
            if (err)
            {
                future.fulfill(err);
                return;
            }

            // Now do something else.
            somethingElseAsynchronous(function(err, anotherResult)
            {
                if (err)
                {
                    future.fulfill(err);
                    return;
                }

                var myOperationResult = result + anotherResult;
                future.fulfill(undefined, myOperationResult);
            });

        });
        return future;
    }


    var futureResult = doSomethingInTheFuture();
    futureResult.when(function(err, result))
    {
        // Code to handle async return.
    });

As you can see, the code to handle errors is boring and repetitive.  Enter this module.  It will save you time.  And
make you happy.  Like this:

    var Future = require('futures').future;
    var eh = require('vnodelib').load('error-handling');
    .
    .
    .
    function doSomethingInTheFuture()
    {
        var future = new Future()
        var wrap = eh.createWrapperFromFuture(future);

        someAsynchronousOperation(wrap(function(result)
        {
            // Now do something else.
            somethingElseAsynchronous(wrap(function(anotherResult)
            {
                var myOperationResult = result + anotherResult;
                future.fulfill(undefined, myOperationResult);
            }));

        }));
        return future;
    }


    var futureResult = doSomethingInTheFuture();
    futureResult.when(function(err, result))
    {
        // Code to handle async return.
    });

See?  Lots of boilerplate cut out of the picture.

Of course, you needn't just use error-handling with Future.  You can do it like this:

    var eh = require('vnodelib').load('error-handling');
    .
    .
    .
    function doSomethingInTheFuture(callback)
    {
        var wrap = eh.createWrapperFromCallback(function(err)
        {
            // Custom logging or whatever goes here.

            // Tell the callback that something really bad happened.
            callback(err);
        });

        someAsynchronousOperation(wrap(function(result)
        {
            // Now do something else.
            somethingElseAsynchronous(wrap(function(anotherResult)
            {
                var myOperationResult = result + anotherResult;
                callback(undefined, myOperationResult);
            }));

        }));
        return future;
    }

If you're still not convinced, try using Future or even the standard async pattern where errors are involved, for
anything other than a trivial example.  You'll be sad.  Then you can come back here.  And be happy.