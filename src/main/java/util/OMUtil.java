package util;

import java.util.ArrayList;
import java.util.List;

public class OMUtil {

    private static final int NUM = 13;

    public static <T> List<T> splitResultByPage(List<T> unHandleList, int page) {
        List<T> result = new ArrayList<T>();
        if (unHandleList.size() < 10) {
            for (int i = 0; i < unHandleList.size(); i++) {
                result.add(unHandleList.get(i));
            }
        } else {
            for (int i = (page - 1) * 10; i < ((page - 1) * 10) + NUM; i++) {
                result.add(unHandleList.get(i));
            }
        }
        return result;
    }

}
