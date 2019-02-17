const google = require('googleapis');

exports.createOAuth = function (clientId) {
    return function (clientSecret) {
        return function (redirectUri) {
            return function() {
                return new google.auth.OAuth2(
                    clientId,
                    clientSecret,
                    redirectUri
                );
            };
        };
    };
};

exports.generateAuthUrl = function (oauth) {
    return function (scopes) {
        return function () {
            const url = oauth.generateAuthUrl({
                // 'online' (default) or 'offline' (gets refresh_token)
                access_type: 'offline',
                // If you only need one scope you can pass it as a string
                scope: scopes
            });
            return url;
        };
    };
};

exports._getToken = function (errCB, scCB, oauth, code) {
    return function () {
        return oauth.getToken(code)
        .then(function(token){
            oauth.setCredentials(token);
            scCB(token)();
        })
        .catch(function(err) {
            errCB(err)();
        });     
    };  
};