<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:url var="classesUrl" value="/keycloak-users" />

<c:set var="className" value="Class" />

<div class="jumbotron jumbotron-billboard">
  <div class="img"></div>
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
              <h2>${intestazione}</h2>
                <p>
                    <a href="${classesUrl}">Visualizza ${className}es</a>
                    <c:out value="${response}" />
                </p>
                <a href="/api/homepage" id="SignUp" class="btn btn btn-success btn-lg">Accedi</a>
            </div>
        </div>
    </div>
</div>
