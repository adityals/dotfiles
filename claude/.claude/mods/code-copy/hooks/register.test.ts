import { expect, test } from 'claude-code/testing'
import { codeBlocks } from './register'

test('finds closed fences only, with their language', () => {
  const md = 'hi\n```ts\nconst a = 1\n```\ntext\n~~~\nls -la\n~~~\n```py\nopen'
  expect(codeBlocks(md)).toEqual([
    { lang: 'ts', code: 'const a = 1' },
    { lang: '', code: 'ls -la' },
  ])
})
