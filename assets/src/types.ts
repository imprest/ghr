export type Status = 'init' | 'loading' | 'loaded' | 'error';

export type Order = 'asc' | 'desc';

export type Store<T> = {
	// status: Status; // using a global status on app model
	// error: string; // using a global error on app model
	// updated_at?: Date; // not doing any caching logic. Hence not necessary
	data: T;
	sortOrder?: Order;
	sortBy?: T extends any[] ? keyof any : keyof T;
};

export type Management = {
	base_salary: string;
	cash_allowance: string;
	earned_salary: string;
	gra_category: string;
	id: string;
	living: string;
	living_percent: string;
	month: string;
	name: string;
	net_pay: string;
	nia_no: string;
	non_cash: string;
	non_cash_percent: string;
	overtime_earned: string;
	overtime_tax: string;
	pf_amount: string;
	ssnit_amount: string;
	ssnit_ded: string;
	ssnit_emp_contrib: string;
	ssnit_no: string;
	ssnit_tier_1: string;
	ssnit_tier_2: string;
	ssnit_total: string;
	tax_ded: string;
	taxable_income: string;
	tin_no: string;
	total_additions: string;
	total_cash: string;
	total_gra_income: string;
	total_relief: string;
	total_tax: string;
	vehicle: string;
};

export type Payroll = {
	advance: string;
	bank: string;
	base_salary: string;
	cash_allowance: string;
	days_worked: string;
	dept: string;
	dob: string;
	earned_salary: string;
	end_date: null;
	gra_category: string;
	id: string;
	is_cash: boolean;
	is_terminated: boolean;
	lmd: Date;
	lmt: '11:58:14';
	lmu: string;
	loan: string;
	month: string;
	name: string;
	net_pay: string;
	nia_no: string;
	overtime_earned: string;
	overtime_tax: string;
	pf_amount: string;
	pf_emp_contrib: string;
	pf_total: string;
	pf_ded: string;
	pf_no: string;
	pvt_loan: string;
	ssnit_amount: string;
	ssnit_ded: string;
	ssnit_emp_contrib: string;
	ssnit_no: string;
	ssnit_t2: string;
	ssnit_tier_1: string;
	ssnit_tier_2: string;
	ssnit_total: string;
	staff_welfare_ded: string;
	start_date: Date;
	sub_dept: string;
	tax_ded: string;
	taxable_income: string;
	tin_no: string;
	title: string;
	total_cash: string;
	total_ded: string;
	total_pay: string;
	total_relief: string;
	total_tax: string;
	tuc_amount: string;
	tuc_ded: string;
};
