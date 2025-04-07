package com.meuprojeto.resources;

// Para Jakarta EE 9+ (Tomcat 10+)
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.core.Response;

@Path("rest")
public class JakartaEE8Resource {
    
    @GET
    public Response ping() {
        return Response
                .ok("ping")
                .build();
    }
}