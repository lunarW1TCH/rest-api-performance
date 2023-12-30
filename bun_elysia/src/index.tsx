import { Elysia, t } from 'elysia';

new Elysia().get('/get', () => 'Hello World').listen(8080);
