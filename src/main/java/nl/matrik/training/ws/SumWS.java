package nl.matrik.training.ws;

import nl.matrik.training.ws.dto.SumResponse;
import nl.matrik.training.ws.dto.SumRequest;

import javax.jws.WebParam;
import javax.jws.WebResult;
import javax.jws.WebService;

@WebService(name="SumWs")
public interface SumWS  {

    @WebResult(name="response")
    SumResponse calculateSum(@WebParam SumRequest request);


}
