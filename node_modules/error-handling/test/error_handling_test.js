/*
 * Copyright 2012 VirtuOz Inc. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/**
 * error_handling_test
 *
 * @author Kevan Dunsmore
 * @created 2012/08/28
 */
var Future = require('futures').future;
var expect = require('chai').expect;
var assert = require('chai').assert;

var eh = require('../index.js');

describe('ErrorHandlingTest', function ()
{
    beforeEach(function (done)
               {
                   done();
               });

    describe('createWrapper', function ()
    {
        it('should succeed and marshal no parameters', function (done)
        {
            // Create an error-handling wrapper.
            var wrap = eh.createWrapper();

            // Now wrap a function.  It should now get error-handling capabilities.
            var wrapped = wrap(function ()
                               {
                                   // Make sure the correct number of arguments have been passed.
                                   expect(arguments.length).to.equal(0);
                                   done();
                               },
                               function ()
                               {
                                   assert.fail('Error handler should never be called');
                               });

            // Call the wrapped function, supplying an undefined error object to signify that we were successful.
            wrapped(undefined);
        });


        it('should succeed and marshal all parameters except the err parameter', function (done)
        {
            // Create an error-handling wrapper.
            var wrap = eh.createWrapper();

            // Now wrap a function.  It should now get error-handling capabilities.
            var wrapped = wrap(function (param1, param2, param3)
                               {
                                   // Make sure the correct number of arguments have been passed.
                                   expect(arguments.length).to.equal(3);

                                   // Make sure the argument values are as expected.
                                   expect(param1).to.equal("value1");
                                   expect(param2).to.equal("value2");
                                   expect(param3).to.equal("value3");

                                   done();
                               },
                               function ()
                               {
                                   assert.fail('Error handler should never be called');
                               });

            // Call the wrapped function, supplying an undefined error object to signify that we were successful.
            wrapped(undefined, "value1", "value2", "value3");
        });


        it('should call the failure callback with just the err parameter', function (done)
        {
            // Create an error-handling wrapper.
            var wrap = eh.createWrapper();

            // Now wrap a function.  It should now get error-handling capabilities.
            var wrapped = wrap(function ()
                               {
                                   assert.fail('Target function should never be called.');
                               },
                               function (err)
                               {
                                   // Make sure the correct number of arguments have been passed.
                                   expect(arguments.length).to.equal(1);

                                   expect(err.message).to.equal('Expected error');
                                   done();
                               });

            // Call the wrapped function, supplying an undefined error object to signify that we were successful.
            wrapped(new Error('Expected error'));
        });


        it('should call the failure callback with all of the parameters', function (done)
        {
            // Create an error-handling wrapper.
            var wrap = eh.createWrapper();

            // Now wrap a function.  It should now get error-handling capabilities.
            var wrapped = wrap(function ()
                               {
                                   assert.fail('Target function should never be called.');
                               },
                               function (err, param1, param2, param3)
                               {
                                   // Make sure the correct number of arguments have been passed.
                                   expect(arguments.length).to.equal(4);

                                   // Make sure the argument values are as expected.
                                   expect(err.message).to.equal('Expected error');
                                   expect(param1).to.equal("value1");
                                   expect(param2).to.equal("value2");
                                   expect(param3).to.equal("value3");

                                   done();
                               });

            // Call the wrapped function, supplying an undefined error object to signify that we were successful.
            wrapped(new Error('Expected error'), 'value1', 'value2', 'value3');
        });
    });


    describe('createWrapperFromFuture', function ()
    {
        it('should succeed and marshal no parameters', function (done)
        {
            // Create a future object and an error-handling wrapper from it.
            var future = new Future();
            var wrap = eh.createWrapperFromFuture(future);

            // Now wrap a function.  It should now get error-handling capabilities.
            var wrapped = wrap(function ()
                               {
                                   // Make sure the correct number of arguments have been passed.
                                   expect(arguments.length).to.equal(0);

                                   // Tell the future object we were successful.
                                   future.fulfill(undefined, "success");
                               });

            // Call the wrapped function, supplying an undefined error object to signify that we were successful.
            wrapped(undefined);

            // Wait for the future to tell us that the wrapped function was called.
            future.when(function (err, value)
                        {
                            expect(err).to.equal(undefined);
                            expect(value).to.equal("success");
                            done();
                        });
        });


        it('should succeed and marshal all parameters except the err parameter', function (done)
        {
            // Create a future object and an error-handling wrapper from it.
            var future = new Future();
            var wrap = eh.createWrapperFromFuture(future);

            // Now wrap a function.  It should now get error-handling capabilities.
            var wrapped = wrap(function (param1, param2, param3)
                               {
                                   // Make sure the correct number of arguments have been passed.
                                   expect(arguments.length).to.equal(3);

                                   // Make sure the argument values are as expected.
                                   expect(param1).to.equal("value1");
                                   expect(param2).to.equal("value2");
                                   expect(param3).to.equal("value3");

                                   // Tell the future object we were successful.
                                   future.fulfill(undefined, "success");
                               });

            // Call the wrapped function, supplying an undefined error object to signify that we were successful and
            // with some parameters.
            wrapped(undefined, "value1", "value2", "value3");

            // Wait for the future to tell us that the wrapped function was called.
            future.when(function (err, value)
                        {
                            expect(err).to.equal(undefined);
                            expect(value).to.equal("success");
                            done();
                        });
        });


        it('should fulfill the future with an error', function (done)
        {
            // Create a future object and an error-handling wrapper from it.
            var future = new Future();
            var wrap = eh.createWrapperFromFuture(future);

            // Now wrap a function.  It should now get error-handling capabilities.
            var wrapped = wrap(function ()
                               {
                                   assert.fail('Target function should never be called.');
                               });

            // Call the wrapped function, supplying an error object to simulate, well, an error.
            wrapped(new Error("This is an expected error"));

            // Wait for the future to tell us that the wrapped function was called.
            future.when(function (err)
                        {
                            expect(arguments.length).to.equal(1);

                            expect(err).to.not.equal(undefined);
                            expect(err.message).to.equal('This is an expected error');

                            done();
                        });
        });


        it('should fulfill the future with an error and other specified parameters', function (done)
        {
            // Create a future object and an error-handling wrapper from it.
            var future = new Future();
            var wrap = eh.createWrapperFromFuture(future);

            // Now wrap a function.  It should now get error-handling capabilities.
            var wrapped = wrap(function ()
                               {
                                   assert.fail('Target function should never be called.');
                               });

            // Call the wrapped function, supplying an error object to simulate, well, an error.
            wrapped(new Error("This is an expected error"), 'value1', 'value2', 'value3');

            // Wait for the future to tell us that the wrapped function was called.
            future.when(function (err, param1, param2, param3)
                        {
                            // Make sure the correct number of arguments have been passed.
                            expect(arguments.length).to.equal(4);

                            // Make sure the argument values are as expected.
                            expect(err.message).to.equal('This is an expected error');
                            expect(param1).to.equal("value1");
                            expect(param2).to.equal("value2");
                            expect(param3).to.equal("value3");

                            done();
                        });
        });
    });
});