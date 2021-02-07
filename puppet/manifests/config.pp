## config.pp ##
File { backup => false }
node default {
 lookup('classes', Array[String], 'unique').include
}
