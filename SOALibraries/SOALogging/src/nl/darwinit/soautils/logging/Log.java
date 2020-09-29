/**
 * @author Martien van den Akker, Darwin-IT Professionals
 * @version 1.0
 *
 * Wrapper class around logging mechanism to get confined and easy log methods.
 * 
 * History
 * 2019-01-19 - 1.0 - Initial Creation
 */
package nl.darwinit.soautils.logging;


import java.util.logging.Level;
import java.util.logging.Logger;


public class Log {
    private static Logger log;
    private String className;
    private boolean toConsole = false;

    /**
     * Only log to console if toConsole is true, unless override is true
     * @param logText
     * @param override
     */
    private void pl(String logText, boolean override) {
        if (toConsole || override) {
            System.out.println(logText);
        }
    }

    /**
     * Only log to console if toConsole is true;
     * @param logText
     */
    private void pl(String logText) {
        pl(logText, false);
    }

    public Log(Class<?> loggingClass) {
        super();
        setClassName(loggingClass.getName());
        log = Logger.getLogger(getClassName());
    }
    
    public Log(String loggingClass) {
        super();
        setClassName(loggingClass);
        log = Logger.getLogger(getClassName());
    }

    private String getText(String methodName, String text) {
        return className + "." + methodName + ": " + text;
    }

    public void debug(String methodName, String text) {
        String logText = getText(methodName, text);
        pl(logText);
        log.fine(logText);
    }

    public void trace(String methodName, String text) {
        String logText = getText(methodName, text);
        log.finest(logText);
    }

    public void info(String methodName, String text) {
        String logText = getText(methodName, text);
        pl(logText);
        log.info(logText);
    }

    public void warn(String methodName, String text) {
        String logText = getText(methodName, text);
        pl(logText);
        log.warning(logText);
    }

    public void warn(String methodName, String text, Exception e) {
        String logText = getText(methodName, text);
        pl(logText, true);
        pl("Error Message: " + e.getMessage());
        pl("Error Caused by: " + e.getCause());
        log.log(Level.WARNING, logText, e);
    }

    public void error(String methodName, String text) {
        String logText = getText(methodName, text);
        pl(logText, true);
        log.severe(logText);
    }


    public void error(String methodName, String text, Exception e) {
        String logText = getText(methodName, text);
        pl(logText, true);
        pl("Error Message: " + e.getMessage());
        pl("Error Caused by: " + e.getCause());
        log.log(Level.SEVERE, logText, e);
    }

    public void start(String methodName) {
        trace(methodName, "Start");
    }

    public void end(String methodName) {
        trace(methodName, "End");
    }

    public final void setToConsole(boolean toConsole) {
        this.toConsole = toConsole;
    }

    public final boolean isToConsole() {
        return toConsole;
    }

    public final void setClassName(String className) {
        this.className = className;
    }

    public final String getClassName() {
        return className;
    }
}
