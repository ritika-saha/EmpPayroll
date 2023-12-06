package com.payroll;

import java.io.File;
import java.io.IOException;
import java.nio.file.DirectoryStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;

public class FileService {
    
    public boolean isExistFile(String path){
        File file=new File(path);
        return file.exists();
    }

    public boolean deleteFile(String path){
        File file=new File(path);
        return file.delete();
    }

    public boolean createDir(String path){
        File file=new File(path);
        return file.mkdir();
    }

    public boolean createFile(String path) throws IOException{
        File file=new File(path);
        return file.createNewFile();
    }

     public List<String> listFiles(String directoryPath, String extension) {
        List<String> fileNames = new ArrayList<>();

        // Check if the directory path is valid
        File dir = new File(directoryPath);
        if (!dir.isDirectory()) {
            System.out.println("Invalid directory path: " + directoryPath);
            return fileNames;
        }

        // Use try-with-resources to automatically close resources
        try (DirectoryStream<Path> directoryStream = Files.newDirectoryStream(dir.toPath(), "*" + extension)) {
            for (Path path : directoryStream) {
                fileNames.add(path.getFileName().toString());
            }
        } catch (IOException e) {
            // Handle IOException, if any
            e.printStackTrace();
        }

        return fileNames;
    }
}
