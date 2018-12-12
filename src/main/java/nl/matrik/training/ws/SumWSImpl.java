package nl.matrik.training.ws;

import nl.matrik.training.ws.dto.SumRequest;
import nl.matrik.training.ws.dto.SumResponse;

public class SumWSImpl implements SumWS {

    @Override
    public SumResponse calculateSum(SumRequest request) {

        int result = request.getNum1() + request.getNum2();

        SumResponse response = new SumResponse();
        response.setResult(result);
        return response;

    }
}
