<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% response.setHeader("Content-Security-Policy", "frame-ancestors 'self' https://keycloak.vrscuola.online:9443;"); %>

<div class="jumbotron jumbotron-billboard">
  <div class="img"></div>
    <div class="container">
        <div class="row">
            <div class="col-lg-12">
              <h2>${intestazione}</h2>
                <p>
                    ${saluti}
                </p>
                <a href="/api/homepage" id="SignUp" class="btn btn btn-success btn-lg">Accedi</a>
            </div>
        </div>
    </div>
</div>