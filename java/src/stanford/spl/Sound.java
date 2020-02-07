/*
 * File: Sound.java
 * ----------------
 * This program implements a Java-based graphics back end for the
 * StanfordCPPLib package.
 */

/*************************************************************************/
/* Stanford Portable Library                                             */
/* Copyright (C) 2013 by Eric Roberts <eroberts@cs.stanford.edu>         */
/*                                                                       */
/* This program is free software: you can redistribute it and/or modify  */
/* it under the terms of the GNU General Public License as published by  */
/* the Free Software Foundation, either version 3 of the License, or     */
/* (at your option) any later version.                                   */
/*                                                                       */
/* This program is distributed in the hope that it will be useful,       */
/* but WITHOUT ANY WARRANTY; without even the implied warranty of        */
/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         */
/* GNU General Public License for more details.                          */
/*                                                                       */
/* You should have received a copy of the GNU General Public License     */
/* along with this program.  If not, see <http://www.gnu.org/licenses/>. */
/*************************************************************************/

package stanford.spl;

import acm.graphics.GObject;
import acm.util.ErrorException;
import acm.util.JTFTools;
import acm.util.TokenScanner;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.InvalidPathException;
import java.nio.file.Path;
import java.nio.file.Paths;

import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.Clip;
import javax.sound.sampled.DataLine.Info;

import javazoom.jl.decoder.JavaLayerException;
import javazoom.jl.player.Player;

public class Sound {

    private String filepath;
    private boolean debug;

    public Sound(String filepath, boolean debug) {
        this.filepath = filepath;
        this.debug = debug;
    }

    public void play() {
        int phraser = filepath.lastIndexOf('.');
        String type = filepath.substring(phraser + 1);
        if (type.equals("wav")) {
            playWav();
        } else if (type.equals("mp3")) {
            playMp3();
        } else {
            if (debug) System.err.println("JavaBackEnd.Sound: play: Unsupported filetype " + type);
        }
    }

    private void playMp3() {
        File file = getMusicFile();
        try {
            Player player = new Player(new FileInputStream(file));
            if (player != null) player.play();
        } catch (FileNotFoundException|JavaLayerException ex) {
            throw new ErrorException("playMp3: " + ex);
        }
    }

    private void playWav() {
        File file = getMusicFile();
        Clip clip = null;
        try {
            AudioInputStream ais = AudioSystem.getAudioInputStream(file);
            Info info = new Info(Clip.class, ais.getFormat());
            clip = (Clip)AudioSystem.getLine(info);
            clip.open(ais);
        } catch (IllegalArgumentException ex) {
            if (debug) System.err.println("JavaBackEnd.Sound: playWav: " + ex);
            // do not throw this exception, because it occurs when no audio device is available		 
        } catch (IOException ex) {
            throw new ErrorException("playWav: File not found");
        } catch (Exception ex) {
            throw new ErrorException("playWav: " + ex);
        }
        if (clip != null) {
            clip.stop();
            clip.setFramePosition(0);
            clip.start();
        }
    }

    private File getMusicFile() {
        try {
            Path path = Paths.get(filepath);
            return path.toFile();
        } catch (InvalidPathException|UnsupportedOperationException ex) {
            if (debug) System.err.println("JavaBackEnd.Sound: getMusicFile: " + ex);
            return null;
        }
    }

}
