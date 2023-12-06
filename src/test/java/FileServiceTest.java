import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.payroll.FileService;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import static org.junit.jupiter.api.Assertions.*;

public class FileServiceTest {
    
    private FileService fileServ = new FileService();;
    private String dirPath= "dir123";
    private String filePath="dir123/file123.txt";
    
    @Test
    void testCreateDir(){
        assertTrue(fileServ.createDir(dirPath+"/testDir"));
    }

    @Test
    void testCreateFile() throws IOException{
        assertTrue(fileServ.createFile(filePath));
    }

    @Test
    void testFileExist() throws IOException{
        assertTrue(fileServ.isExistFile(filePath));
    }

    @Test
    void testDeleteFile() throws IOException{
        assertTrue(fileServ.deleteFile(filePath));
        assertFalse(fileServ.isExistFile(filePath));
    } 

}
