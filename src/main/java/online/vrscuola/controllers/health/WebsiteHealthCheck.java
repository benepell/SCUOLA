package online.vrscuola.controllers.health;

import online.vrscuola.utilities.Constants;
import org.apache.commons.codec.binary.Base64;
import org.apache.http.HttpHeaders;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClientBuilder;
import org.json.JSONObject;

import javax.net.ssl.HttpsURLConnection;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.Charset;

public class WebsiteHealthCheck {

    public static JSONObject checkWebsite(String url) {
        JSONObject response = new JSONObject();
        HttpClient client = HttpClientBuilder.create().build();
        HttpGet request = new HttpGet(url);
        try {
            // disable ssl cert validation
            HttpsURLConnection.setDefaultHostnameVerifier((hostname, sslSession) -> true);

            HttpResponse httpResponse = client.execute(request);
            int statusCode = httpResponse.getStatusLine().getStatusCode();
            if (statusCode >= 200 && statusCode < 300) {
                BufferedReader reader = new BufferedReader(new InputStreamReader(httpResponse.getEntity().getContent()));
                StringBuilder stringBuilder = new StringBuilder();
                String line = null;
                while ((line = reader.readLine()) != null) {
                    stringBuilder.append(line + "\n");
                }
                response.put("status", "ok");
            } else {
                response.put("status", "error");
                response.put("message", "HTTP request failed with status code " + statusCode);
            }
        } catch (IOException e) {
            response.put("status", "error");
            response.put("message", e.getMessage());
        }
        return response;
    }

    public static JSONObject checkWebsite(String url, String username, String password) {
        JSONObject response = new JSONObject();
        HttpClient client = HttpClientBuilder.create().build();
        HttpGet request = new HttpGet(url);

        // add Authorization header
        String auth = username + ":" + password;
        byte[] encodedAuth = Base64.encodeBase64(auth.getBytes(Charset.forName("US-ASCII")));
        String authHeader = "Basic " + new String(encodedAuth);
        request.setHeader(HttpHeaders.AUTHORIZATION, authHeader);

        try {
            // disable ssl cert validation
            HttpsURLConnection.setDefaultHostnameVerifier((hostname, sslSession) -> true);

            HttpResponse httpResponse = client.execute(request);
            int statusCode = httpResponse.getStatusLine().getStatusCode();
            if (statusCode >= 200 && statusCode < 300) {
                BufferedReader reader = new BufferedReader(new InputStreamReader(httpResponse.getEntity().getContent()));
                StringBuilder stringBuilder = new StringBuilder();
                String line = null;
                while ((line = reader.readLine()) != null) {
                    stringBuilder.append(line + "\n");
                }
                response.put("status", "ok");
            } else {
                response.put("status", "error");
                response.put("message", "HTTP request failed with status code " + statusCode);
            }
        } catch (IOException e) {
            response.put("status", "error");
            response.put("message", e.getMessage());
        }
        return response;
    }

}
