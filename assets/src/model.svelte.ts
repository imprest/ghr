import type { Status, Payroll, Management, Store } from './types';

const BASE_YEAR = 2016;
const CUR_YEARS = genCurYears();
// const FIN_YEARS = genFinYears();
// const CUR_DATE = new Date().toISOString().substring(0, 10);

// function genFinYears() {
//   const d = new Date();
//   const m = d.getUTCMonth() + 1;
//   let y = d.getUTCFullYear();
//   y = m < 10 ? y - 1 : y;
//
//   const years = [];
//   for (let i = y; i >= BASE_YEAR; i--) {
//     years.push(i);
//   }
//   return years;
// }

function genCurYears() {
	const d = new Date();
	const y = d.getUTCFullYear();

	const years = [];
	for (let i = y; i >= BASE_YEAR; i--) {
		years.push(i);
	}
	return years;
}

type Model = {
	connected: boolean;
	years: number[];
	year: number;
	month: number;
	months: number[];
	status: Status;
	error_msg: string;
	payroll: Store<Payroll[]>;
	management: Store<Management[]>;
};

export const model = $state(<Model>{
	connected: false,
	years: CUR_YEARS,
	year: CUR_YEARS[0],
	month: new Date().getMonth() + 1,
	months: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
	status: 'init',
	error_msg: '',
	payroll: { data: [], sortOrder: 'asc', sortBy: 'id' },
	management: { data: [], sortOrder: 'asc', sortBy: 'id' }
});
