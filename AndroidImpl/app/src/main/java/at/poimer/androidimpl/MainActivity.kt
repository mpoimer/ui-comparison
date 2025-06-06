package at.poimer.androidimpl

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.Surface
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import at.poimer.androidimpl.navigation.BottomNavigationBar
import at.poimer.androidimpl.ui.theme.AndroidImplTheme


class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            AndroidImplTheme {
                Surface(modifier = Modifier.fillMaxSize()) {
                    BottomNavigationBar()
                }
            }
        }
    }
}