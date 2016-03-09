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
 * error_handling
 *
 * @author Kevan Dunsmore
 * @created 2012/08/28
 */
function createWrapperFromFuture(future)
{
    return createWrapperFromCallback(future.fulfill);
}

function createWrapperFromCallback(callback)
{
    return function (targetFunction)
    {
        return wrap(targetFunction, callback);
    }
}
function createWrapper()
{
    return wrap;
}

function wrap(targetFunction, onErrorCallback)
{
    return function (err)
    {
        var args, i;

        if (err)
        {
            args = [];
            for (i = 0; i < arguments.length; i++)
            {
                args.push(arguments[i]);
            }

            return onErrorCallback.apply(onErrorCallback, args);
        }

        if (arguments.length <= 1)
        {
            // No need for an args array.  Just call the target function.
            return targetFunction();
        }
        else
        {
            // Get all the args except the (undefined) err arg and call the target function with them.
            args = [];
            for (i = 1; i < arguments.length; i++)
            {
                args.push(arguments[i]);
            }

            return targetFunction.apply(targetFunction, args);
        }
    }
}

module.exports.createWrapperFromFuture = createWrapperFromFuture;
module.exports.createWrapperFromCallback = createWrapperFromCallback;
module.exports.createWrapper = createWrapper;
