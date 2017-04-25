import java.util.*;
import java.io.*;

class Main
{

    private static final double LDPI_FACTOR = 0.75;
    private static final double MDPI_FACTOR = 1;
    private static final double HDPI_FACTOR = 1.5;
    private static final double XHDPI_FACTOR = 2.0;
    private static final double XXHDPI_FACTOR = 3.0;
    private static final double XXXHDPI_FACTOR = 4.0;

    private static final String BASE_PATH = "/src/main/res/values";
    private static final String DIMENS_PATH = BASE_PATH + "/dimens.xml";
    private static final String DESTINATION_LDPI_PATH = BASE_PATH + "-ldpi/dimens.xml";
    private static final String DESTINATION_MDPI_PATH = BASE_PATH + "-mdpi/dimens.xml";
    private static final String DESTINATION_HDPI_PATH = BASE_PATH + "-hdpi/dimens.xml";
    private static final String DESTINATION_XHDPI_PATH = BASE_PATH + "-xhdpi/dimens.xml";
    private static final String DESTINATION_XXHDPI_PATH = BASE_PATH + "-xxhdpi/dimens.xml";
    private static final String DESTINATION_XXXHDPI_PATH = BASE_PATH + "-xxxhdpi/dimens.xml";

    public static void main(String[] args) throws IOException
    {
        Scanner in = new Scanner(System.in);
        String currentPath = args[0];
        String projectPath = readProyectPath(in, currentPath);
        String destinationPath = readDestinationPath(in, currentPath);
        String fullPath = projectPath + DIMENS_PATH;

        modifyFileIfNecesary(fullPath, destinationPath + DESTINATION_LDPI_PATH, LDPI_FACTOR);
        modifyFileIfNecesary(fullPath, destinationPath + DESTINATION_MDPI_PATH, MDPI_FACTOR);
        modifyFileIfNecesary(fullPath, destinationPath + DESTINATION_HDPI_PATH, HDPI_FACTOR);
        modifyFileIfNecesary(fullPath, destinationPath + DESTINATION_XHDPI_PATH, XHDPI_FACTOR);
        modifyFileIfNecesary(fullPath, destinationPath + DESTINATION_XXHDPI_PATH, XXHDPI_FACTOR);
        modifyFileIfNecesary(fullPath, destinationPath + DESTINATION_XXXHDPI_PATH, XXXHDPI_FACTOR);
    }

    private static String readProyectPath(Scanner in, String currentPath)
    {
        System.out.println("Enter the location of the project/module");
        String path = in.nextLine();

        if (path == null || path.isEmpty()) {
            path = currentPath;
        }
        return path;
    }

    private static String readDestinationPath(Scanner in, String currentPath)
    {
        System.out.println("Enter the location of the destination");
        String path = in.nextLine();

        if (path == null || path.isEmpty()) {
            path = currentPath;
        }
        return path;
    }

    private static void modifyFileIfNecesary(String source, String target, double factor)
    {
        BufferedReader reader = null;
        BufferedWriter writer = null;

        try {
            createFileIfNecesary(target);

            FileInputStream streamIn = new FileInputStream(source);
            FileOutputStream streamOut = new FileOutputStream(target);
            String line;

            reader = new BufferedReader(new InputStreamReader(streamIn));
            writer = new BufferedWriter(new OutputStreamWriter(streamOut, "utf-8"));

            while ((line = reader.readLine()) != null) {
                writer.write(modifyLineIfNecesary(line, factor));
                writer.newLine();
            }
            writer.flush();
        }
        catch(Exception e) {
            System.out.println("The target file could not be transformed. " + e.getMessage());
        }
        finally {
            if (reader != null) {
                try {
                    reader.close();
                }
                catch(Exception e) {
                    // Ignore
                }
            }
            if (writer != null) {
                try {
                    writer.close();
                }
                catch(Exception e) {
                    // Ignore
                }
            }
        }
    }

    private static String modifyLineIfNecesary(String line, double factor)
    {
        if(line.contains("p</")) {
            int endIndex = line.indexOf("p</");
            int begIndex = line.indexOf(">");

            String prefix = line.substring(0, begIndex + 1);
            String root = line.substring(begIndex + 1, endIndex - 1);
            String suffix = line.substring(endIndex - 1, line.length());

            double dimens = Double.parseDouble(root);
            dimens = dimens * factor * 1000;
            dimens = (double) ((int) dimens);
            dimens = dimens / 1000;

            return prefix + String.valueOf(dimens).replace(".0", "") + suffix;
        }
        return line;
    }

    private static void createFileIfNecesary(String fileName) throws Exception
    {
        File file = new File(fileName);
        File dirs = file.getParentFile();

        if (dirs.mkdirs()) {
            file.createNewFile();
        }
    }

}
