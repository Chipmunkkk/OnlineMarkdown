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

    /**
     * 生成ID
     *
     * @param type ID标识(M-> markdown, A->用户)
     * @return
     */
    public static long generateUID(String type) {
        String str = "";
        String time = String.valueOf(System.currentTimeMillis()).substring(9);
        String salt = String.valueOf((int) ((Math.random() * 9 + 1) * 1000));
        str = String.valueOf(type.hashCode() + crossMerge(time, salt));
        if (str.charAt(0) == '-') {
            str = str.substring(1);
        }
        if (str.length() == 11) {
            str = str.substring(0, 10);
        }
        return Long.parseLong(str);
    }

    /**
     * 将两个字符串交叉混合
     *
     * @param a 字符串a
     * @param b 字符串b
     * @return 混合后的字符串
     */
    private static String crossMerge(String a, String b) {
        char[] result = new char[a.length() + b.length()];
        if (a.length() > b.length()) {
            for (int i = 0; i < a.length(); i++) {
                result[i * 2] = a.charAt(i);
                if (i < b.length()) {
                    result[i * 2 + 1] = b.charAt(i);
                }
            }
        } else {
            for (int i = 0; i < b.length(); i++) {
                result[i * 2] = b.charAt(i);
                if (i < a.length()) {
                    result[i * 2 + 1] = a.charAt(i);
                }
            }
        }
        return String.valueOf(result);
    }

}
