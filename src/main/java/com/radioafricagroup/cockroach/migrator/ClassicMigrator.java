package com.radioafricagroup.cockroach.migrator;

import java.io.*;
import java.net.URISyntaxException;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ClassicMigrator {
    /*
        0. getAllTableNames() - this forms the basis of our loops
        1. extractFullCreateStatements() - index the create DDL against the table name
        2. extractPrimaryKeys() - get the primary key for tables
        4. assembleCreateStatement() -
        5. assembleCompleteFile() -
     */
    private HashMap<String, String> tableMap = new HashMap<String, String>();
    private HashMap<String, String> createMap = new HashMap<String, String>();
    private HashMap<String, String> ddlMap = new HashMap<String, String>();
    private HashMap<String, String> pryKeysmap = new HashMap<String, String>();
    private HashMap<String, String> tableNames = new HashMap<String, String>();
    private String line;
    private String newContent = "";
    private String currentContent = "";
    private String fullContent = "";
    Scanner scanner;
    static ClassLoader classLoader = ClassicMigrator.class.getClassLoader();
    static File file;
    private String oldContent = "";
    private static BufferedReader reader;
    FileWriter writer = null;

    static {
        try {
            file = new File(classLoader.getResource("songa_billing_parent_dev_original.sql").toURI());
        } catch (URISyntaxException e) {
            e.printStackTrace();
        }
    }

    // this is always good practice
    public ClassicMigrator() {
    }



    private HashMap<String, String> extractFullCreateStatements(File file) throws FileNotFoundException {
        scanner = new Scanner(file);
        scanner = scanner.useDelimiter(";");
        while (scanner.hasNextLine()) {
            line = scanner.nextLine();
            if (line.startsWith("CREATE TABLE")) {
                String[] gettableName = line.split(" ");
                gettableName = Arrays.copyOfRange(gettableName, gettableName.length - 2, gettableName.length - 1);
                //for (String tblName:gettableName) {
                List<String> strList2 = Arrays.asList(gettableName);
                String tblName = String.join(" ", strList2);
                createMap.put(tblName, "");

            }
        }

        return createMap;
    }

    private HashMap<String, String> extractUnique(File file) throws FileNotFoundException {
        //getAllTableNames(file);
        scanner = new Scanner(file);
        while (scanner.hasNextLine()) {
            line = scanner.nextLine();
            if (line.startsWith("ALTER")) {
                String[] names = line.split(" ");
                names = Arrays.copyOfRange(names, names.length - 1, names.length);
                for (String name : names) {
                    if (name.contains(".")) {
                        line = scanner.nextLine();
                        if (line.contains("ADD CONSTRAINT")) {
                            String[] getUniq = line.split(" ");
                            /*if (line.contains("PRIMARY")) {
                                getKey = Arrays.copyOfRange(getKey, getKey.length - 3, getKey.length-1);
                            }*/
                            if (line.contains("UNIQUE")) {
                                // System.out.println(line);
                                getUniq = Arrays.copyOfRange(getUniq, getUniq.length - 1, getUniq.length);

                                List<String> strList = Arrays.asList(getUniq);
                                String unique = String.join(" ", strList);
                                //System.out.println(key);
                                tableMap.put(unique, "");
                                //System.out.println(tableMap.keySet());
                            }
                        }
                    }
                }
            }

        }
        return tableMap;
    }

    private HashMap<String, String> extractPrimaryKeys(File file) throws FileNotFoundException {
        //getAllTableNames(file);
        scanner = new Scanner(file);
        while (scanner.hasNextLine()) {
            line = scanner.nextLine();
            if (line.startsWith("ALTER")) {
                String[] names = line.split(" ");
                names = Arrays.copyOfRange(names, names.length - 1, names.length);
                for (String name : names) {
                    if (name.contains(".")) {
                        line = scanner.nextLine();
                        if (line.contains("ADD CONSTRAINT")) {
                            String[] getKey = line.split(" ");
                            if (line.contains("PRIMARY")) {
                                getKey = Arrays.copyOfRange(getKey, getKey.length - 1, getKey.length);

                                List<String> strList = Arrays.asList(getKey);
                                String key = String.join(" ", strList);
                                //System.out.println(key);
                                pryKeysmap.put(name, key);
                                //System.out.println(pryKeysmap.values());
                            }
                        }
                    }
                }
            }

        }
        return pryKeysmap;
    }

    private HashMap<String, String> getCreateStatement(File file) throws IOException {
        String startLine = "CREATE TABLE";
        String endLine = ");";
        String copyStart = "COPY";
        String copyEnd = "\\.";
        scanner = new Scanner(file);
        while (scanner.hasNextLine()) {
            line = scanner.nextLine();
            oldContent = oldContent + line + System.lineSeparator();
            String pattern = String.format("(%s).*?(%s)", Pattern.quote(startLine), Pattern.quote(endLine));
            Matcher m = Pattern.compile(pattern, Pattern.DOTALL).matcher(oldContent);
            writer = new FileWriter("writeDDL.sql");
            while (m.find()) {
                writer.write(m.group() + "\n");
                ddlMap.put(m.group(), "");
                //System.out.println(ddlMap.keySet());
            }
            String pattern2 = String.format("(%s).*?(%s)", Pattern.quote(copyStart), Pattern.quote(copyEnd));
            Matcher m2 = Pattern.compile(pattern2, Pattern.DOTALL).matcher(oldContent);
            while (m2.find()) {
                writer.write(m2.group() + "\n");
            }

        }
        writer.close();
        return ddlMap;
    }

    public String replacePrimaryKey(BufferedReader reader) throws IOException, URISyntaxException {
        extractFullCreateStatements(file);
        extractPrimaryKeys(file);
        reader = new BufferedReader(new FileReader("writeDDL.sql"));
        scanner = new Scanner(reader);
        while (scanner.hasNextLine()) {
            line = scanner.nextLine();
            writer = new FileWriter("writePryKeys.sql");
            newContent = newContent + line + System.lineSeparator();

            String createtblNm = createMap.keySet().toString();
            String newName = createtblNm.replace("[", "").replace("]", "");

            String altertblNm = pryKeysmap.keySet().toString();
            String newNm = altertblNm.replace("[", "").replace("]", "");

            for (String val : pryKeysmap.values()) {
                String newKey = val.replace("(", "").
                        replace(");", "");
                //replace("(", "").replace("]", "");
                //System.out.println(newKey);
                if (newName.equals(newNm)) {
                    if (line.contains("CREATE TABLE")) {
                        line = scanner.nextLine();
                        if (line.contains(newKey) || line.contains("installed_rank")) {
                            newContent = newContent + line.replace("NOT NULL", "PRIMARY KEY");
                        }
                    }

                }

            }
            writer.write(newContent);
        }
        writer.close();
        return null;
    }

    public String assembleCompleteFile(BufferedReader reader) throws IOException, URISyntaxException {
        reader = new BufferedReader(new FileReader("writePryKeys.sql"));
        scanner = new Scanner(reader);

        while (scanner.hasNextLine()) {
            line = scanner.nextLine();
            writer = new FileWriter("writeFile.sql");
            currentContent = currentContent + line + System.lineSeparator();
            if (currentContent.contains("public")) {
                currentContent = currentContent.replace("public", "songa_cockroachdb");
            }

            if (currentContent.contains("uuid_generate_v4()")) {
                currentContent = currentContent.replace("songa_cockroachdb.uuid_generate_v4()",
                        "gen_random_uuid()");
            }
            writer.write(currentContent + "\n");
        }
        writer.close();
        return null;
    }

    public String uniqueReplace(BufferedReader reader) throws IOException {
        extractUnique(file);
        reader = new BufferedReader(new FileReader("writeFile.sql"));
        scanner = new Scanner(reader);
        List<String> results = new ArrayList<String>();
        while (scanner.hasNextLine()) {
            line = scanner.nextLine();
            //line = scanner.nextLine();
            writer = new FileWriter("writeUniqueReplace.sql");
            fullContent = fullContent + line + System.lineSeparator();
            String uniq = tableMap.keySet().toString();
            String text = uniq.replace("[(", "").replace(");]", "");
            if (line.contains(text)) {
                line = line.replace("NOT NULL", "UNIQUE");

            }
            results.add(line);
            String listString = "";
            for (String s : results) {
                listString += s + "\n";
            }
            writer.write(listString);
            System.out.println();
        }
        writer.close();
        return fullContent;
    }

    public static void main(String[] args) throws IOException, URISyntaxException {
        ClassicMigrator migrator = new ClassicMigrator();
        migrator.extractFullCreateStatements(file);
        migrator.extractUnique(file);
        migrator.extractPrimaryKeys(file);
        migrator.getCreateStatement(file);
        migrator.replacePrimaryKey(reader);
        migrator.assembleCompleteFile(reader);
        migrator.uniqueReplace(reader);
    }
}


