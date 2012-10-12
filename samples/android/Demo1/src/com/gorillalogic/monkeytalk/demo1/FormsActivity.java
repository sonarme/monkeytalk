package com.gorillalogic.monkeytalk.demo1;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemSelectedListener;
import android.widget.ArrayAdapter;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.SeekBar;
import android.widget.SeekBar.OnSeekBarChangeListener;
import android.widget.Spinner;
import android.widget.TextView;

public class FormsActivity extends Activity {
	private Spinner spinner;
	private CheckBox checkbox;
	private RadioGroup radios;
	private SeekBar slider;
	private TextView val;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.forms);

		spinner = (Spinner) findViewById(R.id.forms_spinner);
		checkbox = (CheckBox) findViewById(R.id.forms_checkbox);
		radios = (RadioGroup) findViewById(R.id.forms_radios);
		slider = (SeekBar) findViewById(R.id.forms_slider);
		val = (TextView) findViewById(R.id.forms_val);

		// spinner
		ArrayAdapter<CharSequence> adapter = ArrayAdapter.createFromResource(this,
				R.array.formsSpinnerData, android.R.layout.simple_spinner_item);
		adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
		spinner.setAdapter(adapter);

		spinner.setOnItemSelectedListener(new OnItemSelectedListener() {

			@Override
			public void onItemSelected(AdapterView<?> arg0, View arg1, int arg2, long arg3) {
				updateValue();
			}

			@Override
			public void onNothingSelected(AdapterView<?> arg0) {
				updateValue();
			}
		});

		// checkbox
		checkbox.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {

			@Override
			public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
				checkbox.setText(isChecked ? R.string.formsCheckBoxOn : R.string.formsCheckBoxOff);
				updateValue();
			}
		});

		// radios
		radios.setOnCheckedChangeListener(new RadioGroup.OnCheckedChangeListener() {

			@Override
			public void onCheckedChanged(RadioGroup group, int checkedId) {
				updateValue();
			}
		});

		// slider
		slider.setOnSeekBarChangeListener(new OnSeekBarChangeListener() {

			@Override
			public void onStopTrackingTouch(SeekBar seekBar) {
			}

			@Override
			public void onStartTrackingTouch(SeekBar seekBar) {
			}

			@Override
			public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {
				updateValue();
			}
		});

		// lastly, initialize the value
		updateValue();
	}

	private void updateValue() {
		RadioButton radio = (RadioButton) radios.findViewById(radios.getCheckedRadioButtonId());

		StringBuilder sb = new StringBuilder();
		sb.append(spinner.getSelectedItem().toString()).append(" | ");
		sb.append(this.checkbox.isChecked() ? "on | " : "off | ");
		sb.append(radio.getText()).append(" | ");
		sb.append(slider.getProgress());

		val.setText(sb.toString());
	}
}