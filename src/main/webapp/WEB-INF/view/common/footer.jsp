<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<footer class="footer text-xs-center" style="text-align: center;">
	<p class="text-muted">
		<small>&copy; 2023 VRScuola</small>
	</p>
	<p class="text-muted">
		<a href="javascript:showSettingsDialog()"><small>Privacy</small></a>
	</p>
	 <p class="text-muted">
            <a style="margin-bottom: 0;" href='https://play.google.com/store/apps/details?id=org.duckdns.vrscuola'>
                <img alt="Get it on Google Play" src="<c:url value="/static/svg/google-play.svg" />" width="134" height="43" decoding="async" data-nimg="1" class="img-fluid p-1" loading="lazy" style="color:transparent;">
            </a>
     </p>

</footer>