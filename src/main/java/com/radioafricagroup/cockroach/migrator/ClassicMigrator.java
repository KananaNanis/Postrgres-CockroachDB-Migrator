package com.radioafricagroup.cockroach.migrator;
import java.io.*;
import java.net.URISyntaxException;
import java.util.*;
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
    private HashMap<String, String> primaryKeyMap = new HashMap<String, String>();
    private String line;
    Scanner scanner;
    static ClassLoader classLoader = ClassicMigrator.class.getClassLoader();
    static File file;
    private String oldContent;
    FileWriter writer=null;
    static {
        try {
            file = new File(classLoader.getResource("songa_billing_parent_dev_original.sql").toURI());
        } catch (URISyntaxException e) {
            e.printStackTrace();
        }
    }
    // this is always good practice
    public ClassicMigrator(){}

    private HashMap<String, String> getAllTableNames(File file) throws FileNotFoundException {
        scanner= new Scanner(file);
        line = scanner.nextLine();
        while(scanner.hasNextLine()){
            line=scanner.nextLine();
            //System.out.println(line);
            if(line.startsWith("ALTER") ){
                String[] names = line.split(" ");
                names = Arrays.copyOfRange(names, names.length-1, names.length);
                for(String name:names){
                    if(name.contains(".")) {
                        tableMap.put(name, "");
                    }
                }
            }
        }
        return tableMap;
    }
    private HashMap<String, String> extractFullCreateStatements(File file) throws FileNotFoundException {
        scanner= new Scanner(file);
        scanner=scanner.useDelimiter(";");
        while(scanner.hasNextLine()){
            line = scanner.nextLine();
            if(line.startsWith("CREATE TABLE")){
                String[] gettableName = line.split(" ");
                gettableName = Arrays.copyOfRange(gettableName, gettableName.length-2, gettableName.length-1);
                for(String tableName:gettableName){
                    line = scanner.nextLine();
                    String[] getNotNull = line.split(" ");
                    getNotNull= Arrays.copyOfRange(getNotNull, getNotNull.length-2, getNotNull.length);
                    List<String> strList2 = Arrays.asList(getNotNull);
                    String notNull = String.join(" ",strList2);
                    createMap.put(tableName,notNull);
                    //System.out.println(notNull);
                }
            }
        }
        return createMap;
    }
    private HashMap<String, String> extractPrimaryKeys(File file) throws FileNotFoundException {
        getAllTableNames(file);
        scanner= new Scanner(file);
        while(scanner.hasNextLine()){
            line=scanner.nextLine();
            if(line.startsWith("ALTER") ) {
                String[] names = line.split(" ");
                names = Arrays.copyOfRange(names, names.length - 1, names.length);
                for (String name : names) {
                    if (name.contains(".")) {
                    line = scanner.nextLine();
                    if (line.contains("ADD CONSTRAINT")) {
                        String[] getKey = line.split(" ");
                        if (line.contains("PRIMARY")) {
                            getKey = Arrays.copyOfRange(getKey, getKey.length - 3, getKey.length-1);
                        } if (line.contains("UNIQUE")) {
                            getKey = Arrays.copyOfRange(getKey, getKey.length - 2, getKey.length);
                        }
                        List<String> strList = Arrays.asList(getKey);
                        String key = String.join(" ", strList);
                        //System.out.println(key);
                        tableMap.put(name,key);
                    }
                }
            }
                }
            }
        return tableMap;
    }
    public String assembleCreateStatement(File file) throws IOException{
        extractPrimaryKeys(file);
        extractFullCreateStatements(file);
        scanner = new Scanner(file);
        String newValue;
        String[] stringKeys = new String[createMap.keySet().size()];
        createMap.keySet().toArray(stringKeys);
        writer = new FileWriter("writeTo.sql");
        for (String key : stringKeys) {
            String replaceValue = createMap.get(key);
            String pryKey = tableMap.get(key);
            while (scanner.hasNextLine()) {
                line = scanner.nextLine();
                oldContent = oldContent + line + System.lineSeparator();
                if (oldContent.contains("CREATE TABLE")) {
                    oldContent = scanner.nextLine();
                    oldContent = oldContent.replace(replaceValue,pryKey);
                    System.out.println(oldContent);
                    writer.write(oldContent+"\n");
                }
            }
        }
            writer.flush();
            writer.close();
            return null;
        /*String[] tableName = oldContent.split(" ");
        tableName = Arrays.copyOfRange(tableName, tableName.length - 2, tableName.length);
        List<String> strList3 = Arrays.asList(tableName);
        newValue = String.join(" ", strList3);*/
    }

    public String  assembleCompleteFile(File file) throws IOException, URISyntaxException {
        //assembleCreateStatement();
        scanner= new Scanner(file);
        while(scanner.hasNextLine()) {
            line = scanner.nextLine();
            oldContent = oldContent + line + System.lineSeparator();

                if (line.contains("public") || line.contains("uuid")) {
                    String[] words = line.split(" ");
                    for (String newContent : words) {
                        if (newContent.equals("public")) {
                            newContent = oldContent.replace("public", "songa_cockroachdb");
                            writer = new FileWriter("writeFile.sql");
                            writer.write(newContent);
                            //System.out.println(newContent);
                        }
                        if (newContent.contains("uuid_generate_v4()")) {
                            newContent = newContent.replace("songa_cockroachdb.uuid_generate_v4()",
                                    "gen_random_uuid()");
                            writer = new FileWriter("writeFile.sql");
                            writer.write(newContent);
                            System.out.println(newContent);
                        }
                }
            }
        }
                writer.flush();
                return null;
            }

        public static void main(String[] args) throws IOException, URISyntaxException {
        ClassicMigrator migrator = new ClassicMigrator();
        //System.out.println(migrator.getAllTableNames(file));
        migrator.extractFullCreateStatements(file);
        //System.out.println(migrator.extractPrimaryKeys(file));
        //migrator.assembleCompleteFile(file);
          //migrator.assembleCreateStatement(file);
          //migrator.createFile(file);
    }
}
