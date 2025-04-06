package at.poimer.androidimpl.views

import android.icu.text.SimpleDateFormat
import android.util.Log
import androidx.compose.foundation.ExperimentalFoundationApi
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Check
import androidx.compose.material.icons.filled.DateRange
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.Button
import androidx.compose.material3.DatePicker
import androidx.compose.material3.DatePickerDialog
import androidx.compose.material3.DropdownMenuItem
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.ExposedDropdownMenuBox
import androidx.compose.material3.ExposedDropdownMenuDefaults
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.LocalTextStyle
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.MenuAnchorType
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Switch
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.material3.TopAppBar
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.material3.rememberDatePickerState
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableLongStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.input.nestedscroll.nestedScroll
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import at.poimer.androidimpl.models.Gender
import at.poimer.androidimpl.ui.theme.AndroidImplTheme
import java.sql.Date
import java.time.LocalDateTime
import java.time.ZoneOffset
import java.util.Locale

@OptIn(ExperimentalMaterial3Api::class, ExperimentalFoundationApi::class)
@Composable
fun SettingsScreen(modifier: Modifier = Modifier) {
    var firstName by remember { mutableStateOf("") }
    var lastName by remember { mutableStateOf("") }
    var emailUpdates by remember { mutableStateOf(false) }
    var birthDate by remember {
        mutableLongStateOf(
            LocalDateTime.now().toInstant(ZoneOffset.UTC).toEpochMilli()
        )

    }
    var deleteAccountDialogOpen by remember { mutableStateOf(false) }
    var showDatePicker by remember { mutableStateOf(false) }
    val datePickerValue = convertMillisToDate(birthDate)
    val scrollBehavior = TopAppBarDefaults.pinnedScrollBehavior()

    Scaffold(
        modifier = Modifier.nestedScroll(scrollBehavior.nestedScrollConnection),
        topBar = {
            TopAppBar(
                scrollBehavior = scrollBehavior,
                title = {
                    Text("Settings")
                },
            )
        },
    ) { paddingValues ->
        LazyColumn(
            contentPadding = paddingValues,
            modifier = Modifier
                .fillMaxSize()
                .padding(PaddingValues(horizontal = 16.dp)),
            verticalArrangement = Arrangement.spacedBy(8.dp)
        ) {
            // Personal Information
            item {
                Text("Personal Information")
            }
            item {
                OutlinedTextField(
                    modifier = Modifier.fillMaxWidth(),
                    label = { Text("First Name") },
                    value = firstName,
                    onValueChange = { value -> firstName = value })
            }
            item {
                OutlinedTextField(
                    modifier = Modifier.fillMaxWidth(),
                    label = { Text("Last Name") },
                    value = lastName,
                    onValueChange = { value -> lastName = value })
            }
            item {
                GenderSelection()
            }
            item {
                OutlinedTextField(
                    modifier = Modifier.fillMaxWidth(),
                    label = { Text("Birthdate") },
                    value = datePickerValue,
                    onValueChange = {},
                    readOnly = true,
                    trailingIcon = {
                        IconButton(onClick = { showDatePicker = true }) {
                            Icon(
                                imageVector = Icons.Default.DateRange,
                                contentDescription = "Select date"
                            )
                        }
                    },
                )
                if (showDatePicker) {
                    DialogDatePicker(
                        onDismiss = { showDatePicker = false },
                        onDateSelected = { date ->
                            if (date != null) {
                                birthDate = date
                            }
                            showDatePicker = false
                        },
                        initialDate = birthDate
                    )
                }
            }

            item {
                Spacer(modifier = Modifier.height(16.dp))
            }

            // Contact
            stickyHeader {
                Text("Contact")
            }
            item {
                Row(
                    modifier = Modifier
                        .fillMaxWidth()
                        .clickable {
                            emailUpdates = !emailUpdates
                        },
                    horizontalArrangement = Arrangement.SpaceBetween,
                    verticalAlignment = Alignment.CenterVertically,
                ) {
                    Text("Email Updates")
                    Switch(
                        checked = emailUpdates,
                        onCheckedChange = { value -> emailUpdates = value },
                    )
                }
            }

            // Save
            item {
                Button(
                    modifier = Modifier.fillMaxWidth(), onClick = {}) {
                    Text("Save")
                }
            }

            item {
                Spacer(modifier = Modifier.height(24.dp))
                TextButton(
                    onClick = {
                        deleteAccountDialogOpen = true
                    }) {
                    Text(
                        "Delete Account", style = LocalTextStyle.current.copy(
                            color = MaterialTheme.colorScheme.error
                        )
                    )
                }
            }
        }
    }

    if (deleteAccountDialogOpen) {
        DeleteAccountDialog(
            onDismissRequest = {
                deleteAccountDialogOpen = false
            })
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun GenderSelection() {
    var expanded by remember { mutableStateOf(false) }
    var selected by remember { mutableStateOf(Gender.OTHER) }

    ExposedDropdownMenuBox(
        modifier = Modifier.fillMaxWidth(),
        expanded = expanded,
        onExpandedChange = { isExpanded -> expanded = isExpanded },
    ) {
        OutlinedTextField(
            modifier = Modifier
                .menuAnchor(type = MenuAnchorType.PrimaryNotEditable)
                .fillMaxWidth(),
            label = {
                Text("Gender")
            },
            value = selected.title,
            onValueChange = {},
            readOnly = true,
            trailingIcon = {
                ExposedDropdownMenuDefaults.TrailingIcon(expanded = expanded)
            },
        )
        ExposedDropdownMenu(
            expanded = expanded, onDismissRequest = {
                expanded = false
            }) {
            Gender.entries.forEach { item ->
                DropdownMenuItem(
                    contentPadding = ExposedDropdownMenuDefaults.ItemContentPadding,
                    text = {
                        Text(item.title, style = MaterialTheme.typography.bodyLarge)
                    },
                    onClick = {
                        selected = item
                        expanded = false
                    },
                    leadingIcon = {
                        if (item == selected) {
                            Icon(
                                imageVector = Icons.Default.Check, contentDescription = "Selected"
                            )
                        }
                    })
            }
        }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun DialogDatePicker(
    onDismiss: () -> Unit, onDateSelected: (Long?) -> Unit, initialDate: Long
) {
    val datePickerState = rememberDatePickerState(
        initialSelectedDateMillis = initialDate
    )

    DatePickerDialog(onDismissRequest = onDismiss, confirmButton = {
        TextButton(onClick = {
            onDateSelected(datePickerState.selectedDateMillis)
            onDismiss()
        }) {
            Text("OK")
        }
    }, dismissButton = {
        TextButton(onClick = onDismiss) {
            Text("Cancel")
        }
    }) {
        DatePicker(state = datePickerState)
    }
}

fun convertMillisToDate(millis: Long): String {
    val formatter = SimpleDateFormat("dd.MM.yyyy", Locale.getDefault())
    return formatter.format(Date(millis))
}

@Composable
fun DeleteAccountDialog(
    onDismissRequest: () -> Unit
) {
    AlertDialog(onDismissRequest = onDismissRequest, title = {
        Text("Delete Account")
    }, text = {
        Text("Are you sure you want to delete your account?")
    }, dismissButton = {
        TextButton(
            onClick = onDismissRequest
        ) {
            Text("Cancel")
        }
    }, confirmButton = {
        TextButton(
            onClick = onDismissRequest
        ) {
            Text("Delete")
        }
    })
}

@Preview(showBackground = true)
@Composable
fun SettingsPreview() {
    AndroidImplTheme {
        SettingsScreen()
    }
}