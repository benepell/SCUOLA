<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=social.displayInfo; section>
    <#if section = "title">
        ${msg("loginTitle",(realm.displayName!''))}
    <#elseif section = "header">
        <link href="${url.resourcesPath}/img/favicon.png" rel="icon"/>
        <script>
            function togglePassword() {
                var x = document.getElementById("password");
                var v = document.getElementById("vi");
                if (x.type === "password") {
                    x.type = "text";
                    v.src = "${url.resourcesPath}/img/eye.png";
                } else {
                    x.type = "password";
                    v.src = "${url.resourcesPath}/img/eye-off.png";
                }
            }
        </script>
    <#elseif section = "form">
        <div>
            <img class="logo" src="${url.resourcesPath}/img/vrscuola-logo.svg" alt="VrScuola">
        </div>
        <div class="box-container">
            <div>
                <p class="application-name">VrScuola Autenticazione</p>
            </div>
        <#if realm.password>
            <div>
               <form id="kc-form-login" class="form" onsubmit="return true;" action="${url.loginAction}" method="post">
                    <input id="username" class="login-field" placeholder="${msg("username")}" type="text" name="username">
                    <div>
                        <label class="visibility" id="v" onclick="togglePassword()"><img id="vi" src="${url.resourcesPath}/img/eye-off.png" width="14px" height="14px" alt="vi"></label>
                    </div>
                <input id="password" class="login-field" placeholder="${msg("password")}" type="password" name="password">
                <input class="submit" type="submit" value="${msg("doLogIn")}">
                </form>
            </div>
        </#if>
      <#if social.providers??>
          <p class="para">&nbsp;</p>
          <div id="social-providers">
              <#list social.providers as p>
              <#if p.displayName == "Google">
                  <a href="${p.loginUrl}"><img src="${url.resourcesPath}/img/google-signin.png" alt="Login with Google" class="social-icon-style"></a>
              <#elseif p.displayName == "GitHub">
                  <a href="${p.loginUrl}"><img src="${url.resourcesPath}/img/github-signin.png" alt="Login with GitHub" class="social-icon-style2"></a>
              <#else>
                  <input class="social-link-style" type="button" onclick="location.href='${p.loginUrl}';" value="${p.displayName}"></input>
              </#if>
              </#list>
          </div>
      </#if>
        </div>
        <div>
            <p class="copyright">&copy; ${msg("copyright", "${.now?string('yyyy')}")}</p>
        </div>
    </#if>
</@layout.registrationLayout>
