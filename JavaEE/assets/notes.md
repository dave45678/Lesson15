### Cloudinary notes

official urls:
http://cloudinary.com/documentation/java_integration
http://cloudinary.com/documentation/java_additional_topics#admin_api


tag libraries:
http://docs.oracle.com/javaee/5/tutorial/doc/bnaiy.html





sample code
https://www.javatips.net/api/WhatsThat-master/app/src/main/java/dan/dit/whatsthat/util/webPhotoSharing/PhotoAlbumShareController.java
```java
import android.net.Uri;
import android.text.TextUtils;
import android.util.Log;

import com.cloudinary.*;
import com.cloudinary.utils.ObjectUtils;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Map;

/**
 * http://cloudinary.com/documentation/java_integration
 * Created by daniel on 27.11.15.
 */
public class CloudinaryController extends PhotoAlbumShareController {

    private final Cloudinary mCloudinary;

    public  CloudinaryController() {
        // do not mess with api_secret boys and girls...
        mCloudinary = new Cloudinary(ObjectUtils.asMap(
                "cloud_name", "whatsthat",
                "api_key", "573493652391299",
                "api_secret", "9w7fbIr3pQOSb63QEg0vRBSACvw"));
    }

    private static  String cropSuffixIfAvailable(String toCrop, String suffix) {
        if (TextUtils.isEmpty(toCrop) || TextUtils.isEmpty(suffix) || toCrop.length() < suffix
                .length()) {
            return toCrop;
        }
        if (toCrop.endsWith(suffix)) {
            return toCrop.substring(0, toCrop.length() - suffix.length());
        }
        return toCrop;
    }
    @Override
    public  String uploadPhotoToAlbum(String albumHash, File photo) {
        Map result;
        String publicId = albumHash + cropSuffixIfAvailable(photo.getName(), ".png");
        try {
            result = mCloudinary.uploader().upload(new BufferedInputStream(new FileInputStream
                    (photo)), ObjectUtils.asMap("public_id", publicId));
        } catch (IOException e) {
            Log.e("HomeStuff", "Error uploading photo to cloudinary: " + e);
            return null;
        }
        Log.d("HomeStuff", "Upload result: " + result);
        if (result.containsKey("url")) {
            return (String) result.get("url");
        }
        return null;
    }

    @Override
    public  URL makeShareLink(String photoLink) {
        try {
            return new URL(photoLink);
        } catch (MalformedURLException e) {
            return null;
        }
    }

    private static  String makeAlbumHash(String oldAlbumHash, String albumName, boolean
            albumPublic) {
        return albumName + (albumPublic ? "1" : "0") + "_";
    }

    @Override
    public  String updateAlbum(String albumHash, String albumName, boolean albumPublic) {
        // will not update "old album" photos
        return makeAlbumHash(albumHash, albumName, albumPublic);
    }

    @Override
    public  String makeAlbum(String albumName) {
        // as cloudinary does not support albums we just add a prefix to the image
        // this does not prevent duplicate album names, but this is more of a sorting type of thing
        // then a strict id
        return makeAlbumHash(null, albumName, PhotoAlbumShareController.IS_ALBUM_PUBLIC_DEFAULT);
    }

    @Override
    public  URL makeDownloadLink(Uri shared) {
        try {
            return new URL(shared.toString());
        } catch (MalformedURLException e) {
            return null;
        }
    }
}
```

```java
import android.net.Uri;

import java.io.File;
import java.net.URL;

/**
 * Created by daniel on 26.11.15.
 */
public abstract class PhotoAlbumShareController {

    public static final boolean IS_ALBUM_PUBLIC_DEFAULT = false;

    public abstract  String uploadPhotoToAlbum(String albumHash, File photo);

    public abstract  URL makeShareLink(String photoLink);

    public abstract  String updateAlbum(String albumHash, String albumName, boolean albumPublic);

    public abstract  String makeAlbum(String albumName);

    public abstract  URL makeDownloadLink(Uri shared);
}
```
